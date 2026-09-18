import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/trip.dart';

abstract class TripRepository {
  /// سفرهای یه خط خاص
  Future<Either<Failure, List<Trip>>> getTripsByRoute(String routeId);

  /// سفرهای امروز یه خط
  Future<Either<Failure, List<Trip>>> getTodayTripsByRoute(String routeId);

  /// یه سفر خاص
  Future<Either<Failure, Trip>> getTripById(String id);

  /// سفرهای نزدیک یه ایستگاه
  Future<Either<Failure, List<Trip>>> getUpcomingTripsAtStation(
    String stationId, {
    int limitMinutes = 60,
  });

  /// آپدیت ظرفیت یه سفر (وقتی کسی رزرو می‌کنه)
  Future<Either<Failure, Trip>> updateOccupied(String tripId, int newOccupied);

  /// آپدیت موقعیت زنده‌ی اتوبوس
  Future<Either<Failure, Trip>> updateLocation(
    String tripId, {
    required double lat,
    required double lng,
  });
}