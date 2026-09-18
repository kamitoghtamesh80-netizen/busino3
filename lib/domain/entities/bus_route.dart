import 'package:equatable/equatable.dart';

class BusRoute extends Equatable {
  final String id;
  final String code;
  final String name;
  final String originStationId;
  final String destStationId;
  final List<String> stopIds;
  final int price;
  final int durationMinutes;

  const BusRoute({
    required this.id,
    required this.code,
    required this.name,
    required this.originStationId,
    required this.destStationId,
    required this.stopIds,
    required this.price,
    required this.durationMinutes,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        originStationId,
        destStationId,
        stopIds,
        price,
        durationMinutes,
      ];
}