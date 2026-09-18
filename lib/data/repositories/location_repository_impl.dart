import 'dart:math' as math;

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/errors/failures.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Either<Failure, ({double lat, double lng})>> getCurrentPosition() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        return const Left(
          LocationFailure('سرویس موقعیت مکانی خاموش است'),
        );
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return const Left(
          PermissionFailure('اجازه‌ی دسترسی به موقعیت داده نشده'),
        );
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return Right((lat: pos.latitude, lng: pos.longitude));
    } catch (e) {
      return Left(LocationFailure('خطا در گرفتن موقعیت: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      return Right(
        permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always,
      );
    } catch (e) {
      return Left(PermissionFailure('خطا در چک اجازه: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermission() async {
    try {
      final permission = await Geolocator.requestPermission();
      return Right(
        permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always,
      );
    } catch (e) {
      return Left(PermissionFailure('خطا در درخواست اجازه: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLocationServiceEnabled() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      return Right(enabled);
    } catch (e) {
      return Left(LocationFailure('خطا در بررسی سرویس موقعیت: $e'));
    }
  }

  @override
  double calculateDistance({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    const earthRadius = 6371000.0;
    final dLat = _toRadians(lat2 - lat1);
    final dLng = _toRadians(lng2 - lng1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double deg) => deg * math.pi / 180;
}