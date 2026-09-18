import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/station.dart';
import '../../repositories/station_repository.dart';

class SearchStations {
  final StationRepository _repository;
  SearchStations(this._repository);

  Future<Either<Failure, List<Station>>> call(SearchStationsParams params) {
    return _repository.searchStations(params.query);
  }
}

class SearchStationsParams extends Equatable {
  final String query;
  const SearchStationsParams(this.query);

  @override
  List<Object> get props => [query];
}