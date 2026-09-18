import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/local/database_helper.dart';
import '../mappers/entity_mappers.dart';
import '../models/reservation_model.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final DatabaseHelper _dbHelper;
  static const _uuid = Uuid();

  ReservationRepositoryImpl(this._dbHelper);

  @override
  Future<Either<Failure, Reservation>> createReservation({
    required String userId,
    required String tripId,
    required String routeId,
    required String originStationId,
    required String destStationId,
    required int price,
  }) async {
    try {
      final db = await _dbHelper.database;
      final now = DateTime.now().millisecondsSinceEpoch;

      final model = ReservationModel(
        id: _uuid.v4(),
        userId: userId,
        tripId: tripId,
        routeId: routeId,
        originStationId: originStationId,
        destStationId: destStationId,
        status: AppConstants.ticketPending,
        price: price,
        createdAt: now,
      );

      await db.insert(AppConstants.tableReservations, model.toMap());

      return Right(EntityMappers.reservationFromModel(model));
    } catch (e) {
      return Left(DatabaseFailure('خطا در ساخت رزرو: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> getUserReservations(
    String userId,
  ) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableReservations,
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
      );
      return Right(
        maps
            .map((m) => EntityMappers.reservationFromModel(
                  ReservationModel.fromMap(m),
                ))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن رزروها: $e'));
    }
  }

  @override
  Future<Either<Failure, Reservation>> getReservationById(String id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableReservations,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isEmpty) {
        return const Left(NotFoundFailure('رزرو یافت نشد'));
      }
      return Right(
        EntityMappers.reservationFromModel(
          ReservationModel.fromMap(maps.first),
        ),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن رزرو: $e'));
    }
  }

  @override
  Future<Either<Failure, Reservation>> updateStatus(
    String reservationId,
    String newStatus,
  ) async {
    try {
      final db = await _dbHelper.database;
      final updates = <String, dynamic>{'status': newStatus};
      if (newStatus == AppConstants.ticketConfirmed) {
        updates['confirmed_at'] = DateTime.now().millisecondsSinceEpoch;
      }
      await db.update(
        AppConstants.tableReservations,
        updates,
        where: 'id = ?',
        whereArgs: [reservationId],
      );
      return await getReservationById(reservationId);
    } catch (e) {
      return Left(DatabaseFailure('خطا در آپدیت وضعیت رزرو: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelReservation(
    String reservationId,
  ) async {
    final result = await updateStatus(
      reservationId,
      AppConstants.ticketCancelled,
    );
    return result.fold(
      (failure) => Left(failure),
      (_) => const Right(true),
    );
  }
}