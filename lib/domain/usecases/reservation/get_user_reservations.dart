import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/reservation.dart';
import '../../repositories/reservation_repository.dart';

class GetUserReservations {
  final ReservationRepository _repository;
  GetUserReservations(this._repository);

  Future<Either<Failure, List<Reservation>>> call(
    GetUserReservationsParams params,
  ) {
    return _repository.getUserReservations(params.userId);
  }
}

class GetUserReservationsParams extends Equatable {
  final String userId;
  const GetUserReservationsParams(this.userId);

  @override
  List<Object> get props => [userId];
}