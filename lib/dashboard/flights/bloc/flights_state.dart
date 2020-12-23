part of 'flights_bloc.dart';

abstract class FlightsState extends Equatable {
  const FlightsState();

  @override
  List<Object> get props => [];
}

class FlightsLoaded extends FlightsState {

  final List<Flight> flights;

  FlightsLoaded({@required this.flights});

  @override
  List<Object> get props => [flights];
}

class FlightsLoading extends FlightsState {}

class FlightsError extends FlightsState {}