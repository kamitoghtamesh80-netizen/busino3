import 'dart:math' as math;

import 'package:dartz/dartz.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../domain/entities/nearby_station.dart';
import '../../domain/entities/station.dart';
import '../../domain/repositories/station_repository.dart';
import '../datasources/local/database_helper.dart';
import '../mappers/entity_mappers.dart';
import '../models/station_model.dart';

class StationRepositoryImpl implements StationRepository {
  final DatabaseHelper _dbHelper;

  StationRepositoryImpl(this._dbHelper);

  @override
  Future<Either<Failure, List<Station>>> getAllStations() async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(AppConstants.tableStations);
      final stations = maps
          .map((m) => EntityMappers.stationFromModel(
                StationModel.fromMap(m),
              ))
          .toList();
      return Right(stations);
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن ایستگاه‌ها: $e'));
    }
  }

  @override
  Future<Either<Failure, Station>> getStationById(String id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableStations,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isEmpty) {
        return const Left(NotFoundFailure('ایستگاه یافت نشد'));
      }
      return Right(
        EntityMappers.stationFromModel(StationModel.fromMap(maps.first)),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن ایستگاه: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Station>>> getStationsByRoute(
    String routeId,
  ) async {
    try {
      final db = await _dbHelper.database;
      // ایستگاه‌هایی که route_id توشون هست
      final maps = await db.query(
        AppConstants.tableStations,
        where: "route_ids LIKE ?",
        whereArgs: ['%$routeId%'],
      );
      final stations = maps
          .map((m) => EntityMappers.stationFromModel(
                StationModel.fromMap(m),
              ))
          .toList();
      return Right(stations);
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن ایستگاه‌های خط: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Station>>> searchStations(String query) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableStations,
        where: 'name LIKE ? OR address LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        limit: 20,
      );
      final stations = maps
          .map((m) => EntityMappers.stationFromModel(
                StationModel.fromMap(m),
              ))
          .toList();
      return Right(stations);
    } catch (e) {
      return Left(DatabaseFailure('خطا در جستجوی ایستگاه: $e'));
    }
  }

  @override
  Future<Either<Failure, List<NearbyStation>>> getNearbyStations({
    required double lat,
    required double lng,
    double radiusKm = 2.0,
    int limit = 5,
  }) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(AppConstants.tableStations);

      final withDistance = <NearbyStation>[];

      for (final m in maps) {
        final station = EntityMappers.stationFromModel(
          StationModel.fromMap(m),
        );
        final distMeters = _haversineDistance(
          lat1: lat,
          lng1: lng,
          lat2: station.lat,
          lng2: station.lng,
        );
        if (distMeters <= radiusKm * 1000) {
          final walkMin = (distMeters / 80).ceil(); // ۸۰ متر در دقیقه
          withDistance.add(NearbyStation(
            station: station,
            distanceMeters: distMeters,
            walkingMinutes: walkMin,
          ));
        }
      }

      withDistance.sort(
        (a, b) => a.distanceMeters.compareTo(b.distanceMeters),
      );

      return Right(withDistance.take(limit).toList());
    } catch (e) {
      return Left(DatabaseFailure('خطا در یافتن ایستگاه‌های نزدیک: $e'));
    }
  }

  /// محاسبه‌ی فاصله‌ی دو نقطه روی کره‌ی زمین (متر)
  double _haversineDistance({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    const earthRadius = 6371000.0; // متر
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