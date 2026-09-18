import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/ticket.dart';

abstract class TicketRepository {
  /// صدور بلیط جدید از یه رزرو
  Future<Either<Failure, Ticket>> issueTicket(String reservationId);

  /// گرفتن بلیط‌های یه کاربر
  Future<Either<Failure, List<Ticket>>> getUserTickets(String userId);

  /// یه بلیط خاص
  Future<Either<Failure, Ticket>> getTicketById(String id);

  /// گرفتن بلیط با کد بلیط
  Future<Either<Failure, Ticket>> getTicketByCode(String code);

  /// علامت‌گذاری بلیط به عنوان استفاده‌شده
  Future<Either<Failure, Ticket>> markAsUsed(String ticketId);
}