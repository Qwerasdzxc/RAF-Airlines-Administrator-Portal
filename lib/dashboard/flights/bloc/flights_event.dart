part of 'flights_bloc.dart';

abstract class FlightsEvent extends Equatable {
  const FlightsEvent();

  @override
  List<Object> get props => [];
}

class GetAllFlightsEvent extends FlightsEvent {}

class AddFlightEvent extends FlightsEvent {

  final Flight flight;

  AddFlightEvent({required this.flight});

  @override
  List<Object> get props => [flight];
}

class DeleteFlightEvent extends FlightsEvent {

  final Flight flight;

  DeleteFlightEvent({required this.flight});

  @override
  List<Object> get props => [flight];
}