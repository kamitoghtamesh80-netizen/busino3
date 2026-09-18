import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/trip.dart';
import '../../repositories/trip_repository.dart';

class GetUpcomingTripsAtStation {
  final TripRepository _repository;
  GetUpcomingTripsAtStation(this._repository);

  Future<Either<Failure, List<Trip>>> call(
    GetUpcomingTripsAtStationParams params,
  ) {
    return _repository.getUpcomingTripsAtStation(
      params.stationId,
      limitMinutes: params.limitMinutes,
    );
  }
}

class GetUpcomingTripsAtStationParams extends Equatable {
  final String stationId;
  final int limitMinutes;

  const GetUpcomingTripsAtStationParams({
    required this.stationId,
    this.limitMinutes = 60,
  });

  @override
  List<Object> get props => [stationId, limitMinutes];
}