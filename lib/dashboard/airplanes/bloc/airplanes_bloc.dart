import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/services/airplane/airplane_service.dart';

part 'airplanes_event.dart';
part 'airplanes_state.dart';

class AirplanesBloc extends Bloc<AirplanesEvent, AirplanesState> {

  final AirplaneService service;

  AirplanesBloc({@required this.service}) : super(AirplanesLoading());

  @override
  Stream<AirplanesState> mapEventToState(AirplanesEvent event) async* {
    if (event is GetAllAirplanesEvent) {
      yield AirplanesLoading();

      try {
        final data = await service.getAllAirplanes();

        yield AirplanesLoaded(airplanes: data);
      } catch (e) {
        yield AirplanesError();
      }
    } else if (event is CreateAirplaneEvent) {
      final currState = state;

      yield AirplanesLoading();

      try {
        final newPlane = await service.createAirplane(event.airplane);

        yield AirplanesLoaded(airplanes: (currState as AirplanesLoaded).airplanes..add(newPlane));
      } catch (e) {
        yield AirplanesError();
      }
    } else if (event is DeleteAirplaneEvent) {
      final currState = state;

      yield AirplanesLoading();

      try {
        await service.deleteAirplane(event.airplane);

        yield AirplanesLoaded(airplanes: (currState as AirplanesLoaded).airplanes..remove(event.airplane));
      } catch (e) {
        yield AirplanesError();
      }
    }
  }
}
