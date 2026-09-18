import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String id;
  final String userId;
  final String tripId;
  final String routeId;
  final String originStationId;
  final String destStationId;
  final String status;
  final int price;
  final DateTime createdAt;
  final DateTime? confirmedAt;

  const Reservation({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.routeId,
    required this.originStationId,
    required this.destStationId,
    required this.status,
    required this.price,
    required this.createdAt,
    this.confirmedAt,
  });

  bool get isPending => status == 'pending';
  bool get isConfirmed => status == 'confirmed';
  bool get isCancelled => status == 'cancelled';
  bool get isUsed => status == 'used';
  bool get isExpired => status == 'expired';
  bool get isNoShow => status == 'no_show';
  bool get isWaiting => status == 'waiting';

  @override
  List<Object?> get props => [
        id,
        userId,
        tripId,
        routeId,
        originStationId,
        destStationId,
        status,
        price,
        createdAt,
        confirmedAt,
      ];
}