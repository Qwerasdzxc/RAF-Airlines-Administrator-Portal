import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:raf_airlines_admin/dashboard/airplanes/bloc/airplanes_bloc.dart';
import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/services/airplane/airplane_service.dart';

part 'new_airplane_event.dart';

part 'new_airplane_state.dart';

class NewAirplaneBloc extends Bloc<NewAirplaneEvent, NewAirplaneState> {
  final AirplaneService service;
  final AirplanesBloc airplanesBloc;

  NewAirplaneBloc({@required this.service, @required this.airplanesBloc})
      : super(NewAirplaneInitial());

  @override
  Stream<NewAirplaneState> mapEventToState(NewAirplaneEvent event) async* {
    if (event is NewAirplaneProvided) {
      yield NewAirplaneLoading();

      try {
        int capacity = int.parse(event.capacity);

        final airplane =
            await service.createAirplane(Airplane(name: event.name, capacity: capacity));

        airplanesBloc.add(AddAirplaneEvent(airplane: airplane));

        yield NewAirplaneCreated(airplane: airplane);

        await Future.delayed(Duration(seconds: 2));
        yield NewAirplaneInitial();
      } catch (_) {
        yield NewAirplaneError();
      }
    }
  }
}
