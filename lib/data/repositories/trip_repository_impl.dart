import 'package:dartz/dartz.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/local/database_helper.dart';
import '../mappers/entity_mappers.dart';
import '../models/trip_model.dart';

class TripRepositoryImpl implements TripRepository {
  final DatabaseHelper _dbHelper;

  TripRepositoryImpl(this._dbHelper);

  @override
  Future<Either<Failure, List<Trip>>> getTripsByRoute(String routeId) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableTrips,
        where: 'route_id = ?',
        whereArgs: [routeId],
        orderBy: 'departure_time ASC',
      );
      return Right(
        maps
            .map((m) => EntityMappers.tripFromModel(TripModel.fromMap(m)))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن سفرها: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Trip>>> getTodayTripsByRoute(
    String routeId,
  ) async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day)
          .millisecondsSinceEpoch;
      final endOfDay = startOfDay + 24 * 60 * 60 * 1000;

      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableTrips,
        where: 'route_id = ? AND departure_time >= ? AND departure_time < ?',
        whereArgs: [routeId, startOfDay, endOfDay],
        orderBy: 'departure_time ASC',
      );
      return Right(
        maps
            .map((m) => EntityMappers.tripFromModel(TripModel.fromMap(m)))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن سفرهای امروز: $e'));
    }
  }

  @override
  Future<Either<Failure, Trip>> getTripById(String id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableTrips,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isEmpty) {
        return const Left(NotFoundFailure('سفر یافت نشد'));
      }
      return Right(
        EntityMappers.tripFromModel(TripModel.fromMap(maps.first)),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن سفر: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Trip>>> getUpcomingTripsAtStation(
    String stationId, {
    int limitMinutes = 60,
  }) async {
    try {
      // ایستگاه → خطوط → سفرها
      final db = await _dbHelper.database;

      final stationMaps = await db.query(
        AppConstants.tableStations,
        where: 'id = ?',
        whereArgs: [stationId],
        limit: 1,
      );
      if (stationMaps.isEmpty) {
        return const Left(NotFoundFailure('ایستگاه یافت نشد'));
      }

      final routeMaps = await db.query(
        AppConstants.tableRoutes,
        where: 'stop_ids LIKE ?',
        whereArgs: ['%$stationId%'],
      );
      if (routeMaps.isEmpty) return const Right([]);

      final routeIds = routeMaps.map((e) => e['id'] as String).toList();
      final placeholders = List.filled(routeIds.length, '?').join(',');

      final now = DateTime.now().millisecondsSinceEpoch;
      final until = now + limitMinutes * 60 * 1000;

      final maps = await db.query(
        AppConstants.tableTrips,
        where:
            'route_id IN ($placeholders) AND departure_time >= ? AND departure_time <= ?',
        whereArgs: [...routeIds, now, until],
        orderBy: 'departure_time ASC',
      );

      return Right(
        maps
            .map((m) => EntityMappers.tripFromModel(TripModel.fromMap(m)))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن سفرهای ایستگاه: $e'));
    }
  }

  @override
  Future<Either<Failure, Trip>> updateOccupied(
    String tripId,
    int newOccupied,
  ) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        AppConstants.tableTrips,
        {'occupied': newOccupied},
        where: 'id = ?',
        whereArgs: [tripId],
      );
      return await getTripById(tripId);
    } catch (e) {
      return Left(DatabaseFailure('خطا در آپدیت ظرفیت: $e'));
    }
  }

  @override
  Future<Either<Failure, Trip>> updateLocation(
    String tripId, {
    required double lat,
    required double lng,
  }) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        AppConstants.tableTrips,
        {'current_lat': lat, 'current_lng': lng},
        where: 'id = ?',
        whereArgs: [tripId],
      );
      return await getTripById(tripId);
    } catch (e) {
      return Left(DatabaseFailure('خطا در آپدیت موقعیت: $e'));
    }
  }
}