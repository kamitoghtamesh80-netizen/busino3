import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/bus_route.dart';
import '../../repositories/route_repository.dart';

class SearchRoutes {
  final RouteRepository _repository;
  SearchRoutes(this._repository);

  Future<Either<Failure, List<BusRoute>>> call(SearchRoutesParams params) {
    return _repository.searchRoutes(
      originQuery: params.originQuery,
      destQuery: params.destQuery,
    );
  }
}

class SearchRoutesParams extends Equatable {
  final String originQuery;
  final String destQuery;

  const SearchRoutesParams({
    required this.originQuery,
    required this.destQuery,
  });

  @override
  List<Object> get props => [originQuery, destQuery];
}