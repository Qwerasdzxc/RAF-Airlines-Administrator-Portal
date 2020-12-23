part of 'flights_bloc.dart';

abstract class FlightsState extends Equatable {
  const FlightsState();
}

class FlightsInitial extends FlightsState {
  @override
  List<Object> get props => [];
}
