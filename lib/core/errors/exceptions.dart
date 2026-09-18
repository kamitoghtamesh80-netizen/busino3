class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache error']);
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException([this.message = 'Database error']);
}

class LocationException implements Exception {
  final String message;
  LocationException([this.message = 'Location error']);
}

class PermissionException implements Exception {
  final String message;
  PermissionException([this.message = 'Permission denied']);
}