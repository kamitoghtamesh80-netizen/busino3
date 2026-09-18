import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/app_user.dart';
import '../../repositories/auth_repository.dart';

class Login {
  final AuthRepository _repository;
  Login(this._repository);

  Future<Either<Failure, AppUser>> call(LoginParams params) {
    return _repository.login(
      mobile: params.mobile,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String mobile;
  final String password;

  const LoginParams({required this.mobile, required this.password});

  @override
  List<Object> get props => [mobile, password];
}