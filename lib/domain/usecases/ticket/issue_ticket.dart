import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../entities/ticket.dart';
import '../../repositories/ticket_repository.dart';

class IssueTicket {
  final TicketRepository _repository;
  IssueTicket(this._repository);

  Future<Either<Failure, Ticket>> call(IssueTicketParams params) {
    return _repository.issueTicket(params.reservationId);
  }
}

class IssueTicketParams extends Equatable {
  final String reservationId;
  const IssueTicketParams(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}