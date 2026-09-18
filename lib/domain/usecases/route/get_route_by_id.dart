import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/bus_route.dart';
import '../../repositories/route_repository.dart';

class GetRouteById {
  final RouteRepository _repository;
  GetRouteById(this._repository);

  Future<Either<Failure, BusRoute>> call(GetRouteByIdParams params) {
    return _repository.getRouteById(params.id);
  }
}

class GetRouteByIdParams extends Equatable {
  final String id;
  const GetRouteByIdParams(this.id);

  @override
  List<Object> get props => [id];
}