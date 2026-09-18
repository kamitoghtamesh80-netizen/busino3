import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../repositories/auth_repository.dart';

class Logout {
  final AuthRepository _repository;
  Logout(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.logout();
  }
}