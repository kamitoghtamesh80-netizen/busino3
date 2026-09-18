import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/app_user.dart';
import '../../repositories/auth_repository.dart';

class Register {
  final AuthRepository _repository;
  Register(this._repository);

  Future<Either<Failure, AppUser>> call(RegisterParams params) {
    return _repository.register(
      firstName: params.firstName,
      lastName: params.lastName,
      mobile: params.mobile,
      password: params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String mobile;
  final String password;

  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.password,
  });

  @override
  List<Object> get props => [firstName, lastName, mobile, password];
}