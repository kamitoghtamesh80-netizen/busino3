import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/station.dart';
import '../../repositories/station_repository.dart';

class GetAllStations {
  final StationRepository _repository;
  GetAllStations(this._repository);

  Future<Either<Failure, List<Station>>> call() {
    return _repository.getAllStations();
  }
}