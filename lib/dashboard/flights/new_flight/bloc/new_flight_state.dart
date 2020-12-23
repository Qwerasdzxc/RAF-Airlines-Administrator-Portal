part of 'new_flight_bloc.dart';

abstract class NewFlightState extends Equatable {
  final List<Airplane> airplanes;

  const NewFlightState({@required this.airplanes});

  @override
  List<Object> get props => [airplanes];
}

class NewFlightInitial extends NewFlightState {
  NewFlightInitial({@required List<Airplane> planes}) : super(airplanes: planes);
}

class NewFlightLoading extends NewFlightState {
  NewFlightLoading() : super(airplanes: []);
}

class NewFlightCreated extends NewFlightState {
  final Flight flight;

  NewFlightCreated({@required this.flight, @required List<Airplane> planes})
      : super(airplanes: planes);

  @override
  List<Object> get props => [flight]..addAll(super.props);
}

class NewFlightError extends NewFlightState {

  NewFlightError({@required List<Airplane> planes}) : super(airplanes: planes);
}
