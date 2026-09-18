import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'خطا در دسترسی به دیتابیس']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'خطا در اتصال به اینترنت']);
}

class LocationFailure extends Failure {
  const LocationFailure([super.message = 'دسترسی به موقعیت مکانی امکان‌پذیر نیست']);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'دسترسی موردنیاز داده نشده است']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'موردی یافت نشد']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'اطلاعات ورودی نامعتبر است']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'خطا در حافظه‌ی موقت']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'خطا در احراز هویت']);
}