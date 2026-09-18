class StationModel {
  final String id;
  final String name;
  final String? address;
  final double lat;
  final double lng;
  final List<String> routeIds;
  final int createdAt;

  StationModel({
    required this.id,
    required this.name,
    this.address,
    required this.lat,
    required this.lng,
    this.routeIds = const [],
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'lat': lat,
      'lng': lng,
      'route_ids': routeIds.join(','),
      'created_at': createdAt,
    };
  }

  factory StationModel.fromMap(Map<String, dynamic> map) {
    final routeIdsRaw = map['route_ids'] as String? ?? '';
    return StationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String?,
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
      routeIds: routeIdsRaw.isEmpty ? [] : routeIdsRaw.split(','),
      createdAt: map['created_at'] as int,
    );
  }

  StationModel copyWith({
    String? id,
    String? name,
    String? address,
    double? lat,
    double? lng,
    List<String>? routeIds,
    int? createdAt,
  }) {
    return StationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      routeIds: routeIds ?? this.routeIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}