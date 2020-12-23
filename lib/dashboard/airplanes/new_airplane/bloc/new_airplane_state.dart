part of 'new_airplane_bloc.dart';

abstract class NewAirplaneState extends Equatable {
  const NewAirplaneState();

  @override
  List<Object> get props => [];
}

class NewAirplaneInitial extends NewAirplaneState {}

class NewAirplaneLoading extends NewAirplaneState {}

class NewAirplaneCreated extends NewAirplaneState {

  final Airplane airplane;

  NewAirplaneCreated({@required this.airplane});

  @override
  List<Object> get props => [airplane];
}

class NewAirplaneError extends NewAirplaneState {}