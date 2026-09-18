class TicketModel {
  final String id;
  final String reservationId;
  final String ticketCode;
  final String qrData;
  final int issuedAt;
  final int? expiresAt;
  final int? usedAt;

  TicketModel({
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
    return DateTime.now().millisecondsSinceEpoch > expiresAt!;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_id': reservationId,
      'ticket_code': ticketCode,
      'qr_data': qrData,
      'issued_at': issuedAt,
      'expires_at': expiresAt,
      'used_at': usedAt,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'] as String,
      reservationId: map['reservation_id'] as String,
      ticketCode: map['ticket_code'] as String,
      qrData: map['qr_data'] as String,
      issuedAt: map['issued_at'] as int,
      expiresAt: map['expires_at'] as int?,
      usedAt: map['used_at'] as int?,
    );
  }
}