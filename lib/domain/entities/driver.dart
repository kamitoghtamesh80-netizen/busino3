import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final String id;
  final String name;
  final String? phone;
  final double rating;
  final int totalTrips;

  const Driver({
    required this.id,
    required this.name,
    this.phone,
    this.rating = 0,
    this.totalTrips = 0,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}';
    }
    return name.isNotEmpty ? name[0] : '';
  }

  @override
  List<Object?> get props => [id, name, phone, rating, totalTrips];
}