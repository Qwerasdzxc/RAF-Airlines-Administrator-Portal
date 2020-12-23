part of 'airplanes_bloc.dart';

abstract class AirplanesEvent extends Equatable {

  const AirplanesEvent();

  @override
  List<Object> get props => [];
}

class GetAllAirplanesEvent extends AirplanesEvent {}

class CreateAirplaneEvent extends AirplanesEvent {

  final Airplane airplane;

  CreateAirplaneEvent({@required this.airplane});

  @override
  List<Object> get props => [airplane];
}

class DeleteAirplaneEvent extends AirplanesEvent {

  final Airplane airplane;

  DeleteAirplaneEvent({@required this.airplane});

  @override
  List<Object> get props => [airplane];
}
