import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../entities/nearby_station.dart';
import '../../repositories/station_repository.dart';

class GetNearbyStations {
  final StationRepository _repository;
  GetNearbyStations(this._repository);

  Future<Either<Failure, List<NearbyStation>>> call(
    GetNearbyStationsParams params,
  ) {
    return _repository.getNearbyStations(
      lat: params.lat,
      lng: params.lng,
      radiusKm: params.radiusKm,
      limit: params.limit,
    );
  }
}

class GetNearbyStationsParams extends Equatable {
  final double lat;
  final double lng;
  final double radiusKm;
  final int limit;

  const GetNearbyStationsParams({
    required this.lat,
    required this.lng,
    this.radiusKm = AppConstants.defaultSearchRadiusKm,
    this.limit = AppConstants.maxNearbyStations,
  });

  @override
  List<Object> get props => [lat, lng, radiusKm, limit];
}