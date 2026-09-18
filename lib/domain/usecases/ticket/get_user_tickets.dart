import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/ticket.dart';
import '../../repositories/ticket_repository.dart';

class GetUserTickets {
  final TicketRepository _repository;
  GetUserTickets(this._repository);

  Future<Either<Failure, List<Ticket>>> call(GetUserTicketsParams params) {
    return _repository.getUserTickets(params.userId);
  }
}

class GetUserTicketsParams extends Equatable {
  final String userId;
  const GetUserTicketsParams(this.userId);

  @override
  List<Object> get props => [userId];
}