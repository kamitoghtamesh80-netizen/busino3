import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../repositories/wallet_repository.dart';

class TopUpWallet {
  final WalletRepository _repository;
  TopUpWallet(this._repository);

  Future<Either<Failure, int>> call(TopUpWalletParams params) {
    return _repository.topUp(userId: params.userId, amount: params.amount);
  }
}

class TopUpWalletParams extends Equatable {
  final String userId;
  final int amount;

  const TopUpWalletParams({required this.userId, required this.amount});

  @override
  List<Object> get props => [userId, amount];
}