import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/app_user.dart';

abstract class AuthRepository {
  /// ورود با موبایل و رمز
  Future<Either<Failure, AppUser>> login({
    required String mobile,
    required String password,
  });

  /// ثبت‌نام کاربر جدید
  Future<Either<Failure, AppUser>> register({
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  });

  /// خروج
  Future<Either<Failure, bool>> logout();

  /// کاربر فعلی
  Future<Either<Failure, AppUser?>> getCurrentUser();

  /// چک کردن وضعیت لاگین
  Future<Either<Failure, bool>> isLoggedIn();
}