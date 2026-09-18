import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';

abstract class LocationRepository {
  /// گرفتن موقعیت فعلی
  Future<Either<Failure, ({double lat, double lng})>> getCurrentPosition();

  /// چک کردن اینکه اجازه‌ی GPS داده شده
  Future<Either<Failure, bool>> checkPermission();

  /// درخواست اجازه‌ی GPS
  Future<Either<Failure, bool>> requestPermission();

  /// چک کردن روشن بودن GPS
  Future<Either<Failure, bool>> isLocationServiceEnabled();

  /// فاصله‌ی دو نقطه به متر
  double calculateDistance({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  });
}