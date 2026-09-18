import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/trip.dart';
import '../../repositories/trip_repository.dart';

class GetTripsByRoute {
  final TripRepository _repository;
  GetTripsByRoute(this._repository);

  Future<Either<Failure, List<Trip>>> call(GetTripsByRouteParams params) {
    return _repository.getTripsByRoute(params.routeId);
  }
}

class GetTripsByRouteParams extends Equatable {
  final String routeId;
  const GetTripsByRouteParams(this.routeId);

  @override
  List<Object> get props => [routeId];
}