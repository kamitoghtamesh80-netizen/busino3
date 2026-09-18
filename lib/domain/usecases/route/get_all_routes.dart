import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/bus_route.dart';
import '../../repositories/route_repository.dart';

class GetAllRoutes {
  final RouteRepository _repository;
  GetAllRoutes(this._repository);

  Future<Either<Failure, List<BusRoute>>> call() {
    return _repository.getAllRoutes();
  }
}