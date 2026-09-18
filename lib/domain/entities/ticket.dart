import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String id;
  final String reservationId;
  final String ticketCode;
  final String qrData;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final DateTime? usedAt;

  const Ticket({
    required this.id,
    required this.reservationId,
    required this.ticketCode,
    required this.qrData,
    required this.issuedAt,
    this.expiresAt,
    this.usedAt,
  });

  bool get isUsed => usedAt != null;

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isActive => !isUsed && !isExpired;

  @override
  List<Object?> get props => [
        id,
        reservationId,
        ticketCode,
        qrData,
        issuedAt,
        expiresAt,
        usedAt,
      ];
}