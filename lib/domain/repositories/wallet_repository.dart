import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';

class WalletTransaction {
  final String id;
  final int amount;
  final String type; // 'topup', 'payment', 'refund'
  final String? description;
  final DateTime createdAt;

  WalletTransaction({
    required this.id,
    required this.amount,
    required this.type,
    this.description,
    required this.createdAt,
  });
}

abstract class WalletRepository {
  /// گرفتن موجودی کاربر
  Future<Either<Failure, int>> getBalance(String userId);

  /// شارژ کیف پول
  Future<Either<Failure, int>> topUp({
    required String userId,
    required int amount,
  });

  /// کسر از کیف پول (برای پرداخت بلیط)
  Future<Either<Failure, int>> deduct({
    required String userId,
    required int amount,
    String? description,
  });

  /// برگشت پول (کنسلی)
  Future<Either<Failure, int>> refund({
    required String userId,
    required int amount,
    String? description,
  });

  /// تاریخچه‌ی تراکنش‌ها
  Future<Either<Failure, List<WalletTransaction>>> getTransactions(
    String userId,
  );
}