import 'package:equatable/equatable.dart';

class Trip extends Equatable {
  final String id;
  final String routeId;
  final String? driverId;
  final String busNumber;
  final String? busPlate;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int capacity;
  final int occupied;
  final String status;
  final double? currentLat;
  final double? currentLng;

  const Trip({
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
  });

  int get availableSeats => capacity - occupied;

  double get occupancyPercent =>
      capacity == 0 ? 0 : (occupied / capacity) * 100;

  bool get isFull => occupied >= capacity;

  bool get isAlmostFull => !isFull && occupancyPercent >= 75;

  bool get isAvailable => !isFull && status == 'available';

  Duration get timeUntilDeparture =>
      departureTime.difference(DateTime.now());

  @override
  List<Object?> get props => [
        id,
        routeId,
        driverId,
        busNumber,
        busPlate,
        departureTime,
        arrivalTime,
        capacity,
        occupied,
        status,
        currentLat,
        currentLng,
      ];
}