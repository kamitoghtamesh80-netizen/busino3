import 'package:equatable/equatable.dart';

class Station extends Equatable {
  final String id;
  final String name;
  final String? address;
  final double lat;
  final double lng;
  final List<String> routeIds;

  const Station({
    required this.id,
    required this.name,
    this.address,
    required this.lat,
    required this.lng,
    this.routeIds = const [],
  });

  @override
  List<Object?> get props => [id, name, address, lat, lng, routeIds];
}