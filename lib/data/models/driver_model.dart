class DriverModel {
  final String id;
  final String name;
  final String? phone;
  final double rating;
  final int totalTrips;
  final int createdAt;

  DriverModel({
    required this.id,
    required this.name,
    this.phone,
    this.rating = 0,
    this.totalTrips = 0,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'rating': rating,
      'total_trips': totalTrips,
      'created_at': createdAt,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String?,
      rating: (map['rating'] as num?)?.toDouble() ?? 0,
      totalTrips: map['total_trips'] as int? ?? 0,
      createdAt: map['created_at'] as int,
    );
  }
}