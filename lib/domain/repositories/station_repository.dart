import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/station.dart';
import '../entities/nearby_station.dart';

abstract class StationRepository {
  /// گرفتن همه‌ی ایستگاه‌ها
  Future<Either<Failure, List<Station>>> getAllStations();

  /// گرفتن یه ایستگاه خاص
  Future<Either<Failure, Station>> getStationById(String id);

  /// گرفتن ایستگاه‌های یه خط
  Future<Either<Failure, List<Station>>> getStationsByRoute(String routeId);

  /// جستجوی ایستگاه با اسم
  Future<Either<Failure, List<Station>>> searchStations(String query);

  /// ⭐ گرفتن ایستگاه‌های نزدیک با GPS
  Future<Either<Failure, List<NearbyStation>>> getNearbyStations({
    required double lat,
    required double lng,
    double radiusKm = 2.0,
    int limit = 5,
  });
}