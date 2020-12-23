part of 'airplanes_bloc.dart';

abstract class AirplanesState extends Equatable {
  const AirplanesState();

  @override
  List<Object> get props => [];
}

class AirplanesLoaded extends AirplanesState {

  final List<Airplane> airplanes;

  AirplanesLoaded({@required this.airplanes});

  @override
  List<Object> get props => [airplanes];
}

class AirplanesLoading extends AirplanesState {}

class AirplanesError extends AirplanesState {}