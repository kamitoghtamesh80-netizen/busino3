class TripModel {
  final String id;
  final String routeId;
  final String? driverId;
  final String busNumber;
  final String? busPlate;
  final int departureTime; // milliseconds since epoch
  final int arrivalTime;
  final int capacity;
  final int occupied;
  final String status;
  final double? currentLat;
  final double? currentLng;
  final int createdAt;

  TripModel({
    required this.id,
    required this.routeId,
    this.driverId,
    required this.busNumber,
    this.busPlate,
    required this.departureTime,
    required this.arrivalTime,
    required this.capacity,
    this.occupied = 0,
    required this.status,
    this.currentLat,
    this.currentLng,
    required this.createdAt,
  });

  int get availableSeats => capacity - occupied;

  double get occupancyPercent =>
      capacity == 0 ? 0 : (occupied / capacity) * 100;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'route_id': routeId,
      'driver_id': driverId,
      'bus_number': busNumber,
      'bus_plate': busPlate,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'capacity': capacity,
      'occupied': occupied,
      'status': status,
      'current_lat': currentLat,
      'current_lng': currentLng,
      'created_at': createdAt,
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      id: map['id'] as String,
      routeId: map['route_id'] as String,
      driverId: map['driver_id'] as String?,
      busNumber: map['bus_number'] as String,
      busPlate: map['bus_plate'] as String?,
      departureTime: map['departure_time'] as int,
      arrivalTime: map['arrival_time'] as int,
      capacity: map['capacity'] as int,
      occupied: map['occupied'] as int? ?? 0,
      status: map['status'] as String,
      currentLat: (map['current_lat'] as num?)?.toDouble(),
      currentLng: (map['current_lng'] as num?)?.toDouble(),
      createdAt: map['created_at'] as int,
    );
  }

  TripModel copyWith({
    String? id,
    String? routeId,
    String? driverId,
    String? busNumber,
    String? busPlate,
    int? departureTime,
    int? arrivalTime,
    int? capacity,
    int? occupied,
    String? status,
    double? currentLat,
    double? currentLng,
    int? createdAt,
  }) {
    return TripModel(
      id: id ?? this.id,
      routeId: routeId ?? this.routeId,
      driverId: driverId ?? this.driverId,
      busNumber: busNumber ?? this.busNumber,
      busPlate: busPlate ?? this.busPlate,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      capacity: capacity ?? this.capacity,
      occupied: occupied ?? this.occupied,
      status: status ?? this.status,
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}