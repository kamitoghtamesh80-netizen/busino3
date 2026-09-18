import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/reservation.dart';
import '../../repositories/reservation_repository.dart';

class CreateReservation {
  final ReservationRepository _repository;
  CreateReservation(this._repository);

  Future<Either<Failure, Reservation>> call(
    CreateReservationParams params,
  ) {
    return _repository.createReservation(
      userId: params.userId,
      tripId: params.tripId,
      routeId: params.routeId,
      originStationId: params.originStationId,
      destStationId: params.destStationId,
      price: params.price,
    );
  }
}

class CreateReservationParams extends Equatable {
  final String userId;
  final String tripId;
  final String routeId;
  final String originStationId;
  final String destStationId;
  final int price;

  const CreateReservationParams({
    required this.userId,
    required this.tripId,
    required this.routeId,
    required this.originStationId,
    required this.destStationId,
    required this.price,
  });

  @override
  List<Object> get props => [
        userId,
        tripId,
        routeId,
        originStationId,
        destStationId,
        price,
      ];
}