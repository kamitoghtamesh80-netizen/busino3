import 'package:equatable/equatable.dart';
import 'station.dart';

class NearbyStation extends Equatable {
  final Station station;
  final double distanceMeters;
  final int walkingMinutes;
  final String? nextTripEta; // مثلاً "۶ دقیقه"

  const NearbyStation({
    required this.station,
    required this.distanceMeters,
    required this.walkingMinutes,
    this.nextTripEta,
  });

  String get distanceFormatted {
    if (distanceMeters < 1000) {
      return '${distanceMeters.round()} متر';
    }
    return '${(distanceMeters / 1000).toStringAsFixed(1)} کیلومتر';
  }

  @override
  List<Object?> get props =>
      [station, distanceMeters, walkingMinutes, nextTripEta];
}