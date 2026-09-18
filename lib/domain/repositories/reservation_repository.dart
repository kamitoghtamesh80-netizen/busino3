import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/reservation.dart';

abstract class ReservationRepository {
  /// ساخت رزرو جدید
  Future<Either<Failure, Reservation>> createReservation({
    required String userId,
    required String tripId,
    required String routeId,
    required String originStationId,
    required String destStationId,
    required int price,
  });

  /// گرفتن رزروهای یه کاربر
  Future<Either<Failure, List<Reservation>>> getUserReservations(
    String userId,
  );

  /// یه رزرو خاص
  Future<Either<Failure, Reservation>> getReservationById(String id);

  /// تغییر وضعیت رزرو
  Future<Either<Failure, Reservation>> updateStatus(
    String reservationId,
    String newStatus,
  );

  /// لغو رزرو
  Future<Either<Failure, bool>> cancelReservation(String reservationId);
}