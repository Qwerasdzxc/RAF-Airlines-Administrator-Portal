part of 'new_flight_bloc.dart';

abstract class NewFlightEvent extends Equatable {
  const NewFlightEvent();

  @override
  List<Object> get props => [];
}

class NewFlightInit extends NewFlightEvent {}

class NewFlightProvided extends NewFlightEvent {
  final Airplane airplane;

  final String startDestination;
  final String endDestination;
  final String distance;
  final String price;

  NewFlightProvided(
      {@required this.airplane,
      @required this.startDestination,
      @required this.endDestination,
      @required this.distance,
      @required this.price});

  @override
  List<Object> get props => [airplane, startDestination, endDestination, distance, price];
}
