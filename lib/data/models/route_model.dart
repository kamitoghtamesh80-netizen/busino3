class RouteModel {
  final String id;
  final String code;
  final String name;
  final String originStationId;
  final String destStationId;
  final List<String> stopIds;
  final int price;
  final int durationMinutes;
  final int createdAt;

  RouteModel({
    required this.id,
    required this.code,
    required this.name,
    required this.originStationId,
    required this.destStationId,
    required this.stopIds,
    required this.price,
    required this.durationMinutes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'origin_station_id': originStationId,
      'dest_station_id': destStationId,
      'stop_ids': stopIds.join(','),
      'price': price,
      'duration_minutes': durationMinutes,
      'created_at': createdAt,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    final stopsRaw = map['stop_ids'] as String? ?? '';
    return RouteModel(
      id: map['id'] as String,
      code: map['code'] as String,
      name: map['name'] as String,
      originStationId: map['origin_station_id'] as String,
      destStationId: map['dest_station_id'] as String,
      stopIds: stopsRaw.isEmpty ? [] : stopsRaw.split(','),
      price: map['price'] as int,
      durationMinutes: map['duration_minutes'] as int,
      createdAt: map['created_at'] as int,
    );
  }
}