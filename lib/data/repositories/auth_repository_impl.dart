import 'dart:convert';


import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/database_helper.dart';
import '../mappers/entity_mappers.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DatabaseHelper _dbHelper;
  final SharedPreferences _prefs;
  static const _uuid = Uuid();

  AuthRepositoryImpl(this._dbHelper, this._prefs);

  @override
  Future<Either<Failure, AppUser>> login({
    required String mobile,
    required String password,
  }) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableUsers,
        where: 'mobile = ?',
        whereArgs: [mobile],
        limit: 1,
      );

      if (maps.isEmpty) {
        return const Left(AuthFailure('شماره موبایل ثبت نشده است'));
      }

      final userMap = maps.first;
      final storedHash = userMap['password_hash'] as String?;
      if (storedHash != _hashPassword(password)) {
        return const Left(AuthFailure('رمز عبور اشتباه است'));
      }

      final user = EntityMappers.userFromModel(UserModel.fromMap(userMap));

      // ذخیره وضعیت لاگین
      await _prefs.setBool(AppConstants.prefIsLoggedIn, true);
      await _prefs.setString(AppConstants.prefUserId, user.id);

      return Right(user);
    } catch (e) {
      return Left(AuthFailure('خطا در ورود: $e'));
    }
  }

  @override
  Future<Either<Failure, AppUser>> register({
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    try {
      final db = await _dbHelper.database;

      // چک تکراری نبودن موبایل
      final existing = await db.query(
        AppConstants.tableUsers,
        where: 'mobile = ?',
        whereArgs: [mobile],
        limit: 1,
      );
      if (existing.isNotEmpty) {
        return const Left(AuthFailure('این شماره موبایل قبلاً ثبت شده'));
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final model = UserModel(
        id: _uuid.v4(),
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        passwordHash: _hashPassword(password),
        walletBalance: 0,
        createdAt: now,
      );

      await db.insert(AppConstants.tableUsers, model.toMap());

      await _prefs.setBool(AppConstants.prefIsLoggedIn, true);
      await _prefs.setString(AppConstants.prefUserId, model.id);

      return Right(EntityMappers.userFromModel(model));
    } catch (e) {
      return Left(AuthFailure('خطا در ثبت‌نام: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _prefs.setBool(AppConstants.prefIsLoggedIn, false);
      await _prefs.remove(AppConstants.prefUserId);
      return const Right(true);
    } catch (e) {
      return Left(AuthFailure('خطا در خروج: $e'));
    }
  }

  @override
  Future<Either<Failure, AppUser?>> getCurrentUser() async {
    try {
      final userId = _prefs.getString(AppConstants.prefUserId);
      if (userId == null) return const Right(null);

      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableUsers,
        where: 'id = ?',
        whereArgs: [userId],
        limit: 1,
      );
      if (maps.isEmpty) return const Right(null);

      return Right(
        EntityMappers.userFromModel(UserModel.fromMap(maps.first)),
      );
    } catch (e) {
      return Left(AuthFailure('خطا در خواندن کاربر: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final loggedIn =
          _prefs.getBool(AppConstants.prefIsLoggedIn) ?? false;
      return Right(loggedIn);
    } catch (e) {
      return Left(AuthFailure('خطا در بررسی وضعیت: $e'));
    }
  }

  /// هش ساده (برای mock — در پروداکشن باید از bcrypt استفاده کنی)
  String _hashPassword(String password) {
    final bytes = utf8.encode('busino_salt_$password');
    final hash = bytes.fold<int>(0, (prev, b) => (prev * 31 + b) & 0x7fffffff);
    return hash.toRadixString(16);
  }
}