import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/local/database_helper.dart';

class WalletRepositoryImpl implements WalletRepository {
  final DatabaseHelper _dbHelper;
  static const _uuid = Uuid();

  WalletRepositoryImpl(this._dbHelper);

  @override
  Future<Either<Failure, int>> getBalance(String userId) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableUsers,
        columns: ['wallet_balance'],
        where: 'id = ?',
        whereArgs: [userId],
        limit: 1,
      );
      if (maps.isEmpty) {
        return const Left(NotFoundFailure('کاربر یافت نشد'));
      }
      return Right(maps.first['wallet_balance'] as int? ?? 0);
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن موجودی: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> topUp({
    required String userId,
    required int amount,
  }) async {
    if (amount <= 0) {
      return const Left(ValidationFailure('مبلغ باید بیشتر از صفر باشد'));
    }
    return _changeBalance(
      userId: userId,
      amount: amount,
      type: 'topup',
      description: 'شارژ کیف پول',
    );
  }

  @override
  Future<Either<Failure, int>> deduct({
    required String userId,
    required int amount,
    String? description,
  }) async {
    if (amount <= 0) {
      return const Left(ValidationFailure('مبلغ باید بیشتر از صفر باشد'));
    }
    final balanceResult = await getBalance(userId);
    return balanceResult.fold(
      (failure) => Left(failure),
      (balance) async {
        if (balance < amount) {
          return const Left(ValidationFailure('موجودی کیف پول کافی نیست'));
        }
        return _changeBalance(
          userId: userId,
          amount: -amount,
          type: 'payment',
          description: description ?? 'پرداخت بلیط',
        );
      },
    );
  }

  @override
  Future<Either<Failure, int>> refund({
    required String userId,
    required int amount,
    String? description,
  }) async {
    if (amount <= 0) {
      return const Left(ValidationFailure('مبلغ باید بیشتر از صفر باشد'));
    }
    return _changeBalance(
      userId: userId,
      amount: amount,
      type: 'refund',
      description: description ?? 'برگشت وجه',
    );
  }

  @override
  Future<Either<Failure, List<WalletTransaction>>> getTransactions(
    String userId,
  ) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableWallet,
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
      );
      final list = maps
          .map((m) => WalletTransaction(
                id: m['id'] as String,
                amount: m['amount'] as int,
                type: m['type'] as String,
                description: m['description'] as String?,
                createdAt: DateTime.fromMillisecondsSinceEpoch(
                  m['created_at'] as int,
                ),
              ))
          .toList();
      return Right(list);
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن تراکنش‌ها: $e'));
    }
  }

  Future<Either<Failure, int>> _changeBalance({
    required String userId,
    required int amount,
    required String type,
    String? description,
  }) async {
    try {
      final db = await _dbHelper.database;
      final now = DateTime.now().millisecondsSinceEpoch;

      // تراکنش اتمیک
      await db.transaction((txn) async {
        // ثبت تراکنش
        await txn.insert(AppConstants.tableWallet, {
          'id': _uuid.v4(),
          'user_id': userId,
          'amount': amount,
          'type': type,
          'description': description,
          'created_at': now,
        });

        // آپدیت موجودی
        await txn.rawUpdate(
          'UPDATE ${AppConstants.tableUsers} SET wallet_balance = wallet_balance + ? WHERE id = ?',
          [amount, userId],
        );
      });

      return await getBalance(userId);
    } catch (e) {
      return Left(DatabaseFailure('خطا در تغییر موجودی: $e'));
    }
  }
}