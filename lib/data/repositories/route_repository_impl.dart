import 'package:dartz/dartz.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../domain/entities/bus_route.dart';
import '../../domain/repositories/route_repository.dart';
import '../datasources/local/database_helper.dart';
import '../mappers/entity_mappers.dart';
import '../models/route_model.dart';

class RouteRepositoryImpl implements RouteRepository {
  final DatabaseHelper _dbHelper;

  RouteRepositoryImpl(this._dbHelper);

  @override
  Future<Either<Failure, List<BusRoute>>> getAllRoutes() async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(AppConstants.tableRoutes);
      return Right(
        maps
            .map((m) => EntityMappers.routeFromModel(RouteModel.fromMap(m)))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن خطوط: $e'));
    }
  }

  @override
  Future<Either<Failure, BusRoute>> getRouteById(String id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableRoutes,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isEmpty) {
        return const Left(NotFoundFailure('خط یافت نشد'));
      }
      return Right(
        EntityMappers.routeFromModel(RouteModel.fromMap(maps.first)),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن خط: $e'));
    }
  }

  @override
  Future<Either<Failure, List<BusRoute>>> searchRoutes({
    required String originQuery,
    required String destQuery,
  }) async {
    try {
      final db = await _dbHelper.database;

      // ایستگاه‌های مبدأ و مقصد رو پیدا می‌کنیم
      final originStations = await db.query(
        AppConstants.tableStations,
        columns: ['id'],
        where: 'name LIKE ?',
        whereArgs: ['%$originQuery%'],
      );
      final destStations = await db.query(
        AppConstants.tableStations,
        columns: ['id'],
        where: 'name LIKE ?',
        whereArgs: ['%$destQuery%'],
      );

      if (originStations.isEmpty || destStations.isEmpty) {
        return const Right([]);
      }

      final originIds = originStations.map((e) => e['id'] as String).toList();
      final destIds = destStations.map((e) => e['id'] as String).toList();

      final placeholdersO = List.filled(originIds.length, '?').join(',');
      final placeholdersD = List.filled(destIds.length, '?').join(',');

      final maps = await db.query(
        AppConstants.tableRoutes,
        where:
            'origin_station_id IN ($placeholdersO) AND dest_station_id IN ($placeholdersD)',
        whereArgs: [...originIds, ...destIds],
      );

      return Right(
        maps
            .map((m) => EntityMappers.routeFromModel(RouteModel.fromMap(m)))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در جستجوی خطوط: $e'));
    }
  }

  @override
  Future<Either<Failure, List<BusRoute>>> getRoutesByStation(
    String stationId,
  ) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableRoutes,
        where: 'stop_ids LIKE ?',
        whereArgs: ['%$stationId%'],
      );
      return Right(
        maps
            .map((m) => EntityMappers.routeFromModel(RouteModel.fromMap(m)))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن خطوط ایستگاه: $e'));
    }
  }
}