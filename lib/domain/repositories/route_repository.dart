import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/bus_route.dart';

abstract class RouteRepository {
  /// گرفتن همه‌ی خطوط
  Future<Either<Failure, List<BusRoute>>> getAllRoutes();

  /// گرفتن یه خط خاص
  Future<Either<Failure, BusRoute>> getRouteById(String id);

  /// جستجوی خطوط بر اساس مبدأ و مقصد
  Future<Either<Failure, List<BusRoute>>> searchRoutes({
    required String originQuery,
    required String destQuery,
  });

  /// خطوطی که از یه ایستگاه خاص رد می‌شن
  Future<Either<Failure, List<BusRoute>>> getRoutesByStation(
    String stationId,
  );
}