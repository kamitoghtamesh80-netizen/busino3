import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../repositories/location_repository.dart';

class GetCurrentLocation {
  final LocationRepository _repository;
  GetCurrentLocation(this._repository);

  Future<Either<Failure, ({double lat, double lng})>> call() {
    return _repository.getCurrentPosition();
  }
}