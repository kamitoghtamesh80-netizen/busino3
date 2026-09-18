import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/local/database_helper.dart';
import '../mappers/entity_mappers.dart';
import '../models/ticket_model.dart';

class TicketRepositoryImpl implements TicketRepository {
  final DatabaseHelper _dbHelper;
  static const _uuid = Uuid();

  TicketRepositoryImpl(this._dbHelper);

  @override
  Future<Either<Failure, Ticket>> issueTicket(String reservationId) async {
    try {
      final db = await _dbHelper.database;

      // چک کنیم قبلاً بلیط برای این رزرو صادر نشده
      final existing = await db.query(
        AppConstants.tableTickets,
        where: 'reservation_id = ?',
        whereArgs: [reservationId],
        limit: 1,
      );
      if (existing.isNotEmpty) {
        return Right(
          EntityMappers.ticketFromModel(TicketModel.fromMap(existing.first)),
        );
      }

      final now = DateTime.now();
      final code = _generateTicketCode();
      final model = TicketModel(
        id: _uuid.v4(),
        reservationId: reservationId,
        ticketCode: code,
        qrData: 'BUSINO|$reservationId|$code|${now.millisecondsSinceEpoch}',
        issuedAt: now.millisecondsSinceEpoch,
        expiresAt: now.add(const Duration(hours: 3)).millisecondsSinceEpoch,
      );

      await db.insert(AppConstants.tableTickets, model.toMap());
      return Right(EntityMappers.ticketFromModel(model));
    } catch (e) {
      return Left(DatabaseFailure('خطا در صدور بلیط: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Ticket>>> getUserTickets(String userId) async {
    try {
      final db = await _dbHelper.database;

      // JOIN: tickets → reservations → filter by user
      final maps = await db.rawQuery('''
        SELECT t.* FROM ${AppConstants.tableTickets} t
        INNER JOIN ${AppConstants.tableReservations} r ON r.id = t.reservation_id
        WHERE r.user_id = ?
        ORDER BY t.issued_at DESC
      ''', [userId]);

      return Right(
        maps
            .map((m) => EntityMappers.ticketFromModel(TicketModel.fromMap(m)))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن بلیط‌ها: $e'));
    }
  }

  @override
  Future<Either<Failure, Ticket>> getTicketById(String id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableTickets,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isEmpty) {
        return const Left(NotFoundFailure('بلیط یافت نشد'));
      }
      return Right(
        EntityMappers.ticketFromModel(TicketModel.fromMap(maps.first)),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن بلیط: $e'));
    }
  }

  @override
  Future<Either<Failure, Ticket>> getTicketByCode(String code) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableTickets,
        where: 'ticket_code = ?',
        whereArgs: [code],
        limit: 1,
      );
      if (maps.isEmpty) {
        return const Left(NotFoundFailure('بلیطی با این کد یافت نشد'));
      }
      return Right(
        EntityMappers.ticketFromModel(TicketModel.fromMap(maps.first)),
      );
    } catch (e) {
      return Left(DatabaseFailure('خطا در خواندن بلیط: $e'));
    }
  }

  @override
  Future<Either<Failure, Ticket>> markAsUsed(String ticketId) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        AppConstants.tableTickets,
        {'used_at': DateTime.now().millisecondsSinceEpoch},
        where: 'id = ?',
        whereArgs: [ticketId],
      );
      return await getTicketById(ticketId);
    } catch (e) {
      return Left(DatabaseFailure('خطا در علامت‌گذاری بلیط: $e'));
    }
  }

  String _generateTicketCode() {
    final rand = DateTime.now().microsecondsSinceEpoch % 10000;
    return 'BSN-${rand.toString().padLeft(4, '0')}';
  }
}