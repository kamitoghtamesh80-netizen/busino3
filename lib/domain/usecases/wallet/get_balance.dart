import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../repositories/wallet_repository.dart';

class GetBalance {
  final WalletRepository _repository;
  GetBalance(this._repository);

  Future<Either<Failure, int>> call(GetBalanceParams params) {
    return _repository.getBalance(params.userId);
  }
}

class GetBalanceParams extends Equatable {
  final String userId;
  const GetBalanceParams(this.userId);

  @override
  List<Object> get props => [userId];
}