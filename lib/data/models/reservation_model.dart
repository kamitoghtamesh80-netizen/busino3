class ReservationModel {
  final String id;
  final String userId;
  final String tripId;
  final String routeId;
  final String originStationId;
  final String destStationId;
  final String status;
  final int price;
  final int createdAt;
  final int? confirmedAt;

  ReservationModel({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'trip_id': tripId,
      'route_id': routeId,
      'origin_station_id': originStationId,
      'dest_station_id': destStationId,
      'status': status,
      'price': price,
      'created_at': createdAt,
      'confirmed_at': confirmedAt,
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      tripId: map['trip_id'] as String,
      routeId: map['route_id'] as String,
      originStationId: map['origin_station_id'] as String,
      destStationId: map['dest_station_id'] as String,
      status: map['status'] as String,
      price: map['price'] as int,
      createdAt: map['created_at'] as int,
      confirmedAt: map['confirmed_at'] as int?,
    );
  }
}