part of 'new_airplane_bloc.dart';

abstract class NewAirplaneEvent extends Equatable {
  const NewAirplaneEvent();

  @override
  List<Object> get props => [];
}

class NewAirplaneProvided extends NewAirplaneEvent {

  final String name;
  final String capacity;

  NewAirplaneProvided({required this.name, required this.capacity});

  @override
  List<Object> get props => [name, capacity];
}
