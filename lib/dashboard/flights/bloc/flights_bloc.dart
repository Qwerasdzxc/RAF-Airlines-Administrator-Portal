import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/services/flight/flight_service.dart';

part 'flights_event.dart';
part 'flights_state.dart';

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {

  final FlightService service;

  FlightsBloc({@required this.service}) : super(FlightsLoading());

  @override
  Stream<FlightsState> mapEventToState(FlightsEvent event) async* {
    if (event is GetAllFlightsEvent) {
      yield FlightsLoading();

      try {
        final data = await service.getAllFlights();

        yield FlightsLoaded(flights: data);
      } catch (e) {
        yield FlightsError();
      }
    } else if (event is AddFlightEvent) {
      final currState = state;

      yield FlightsLoading();

      try {
        yield FlightsLoaded(flights: (currState as FlightsLoaded).flights..add(event.flight));
      } catch (e) {
        yield FlightsError();
      }
    } else if (event is DeleteFlightEvent) {
      final currState = state;

      yield FlightsLoading();

      try {
        await service.deleteFlight(event.flight);

        yield FlightsLoaded(flights: (currState as FlightsLoaded).flights..remove(event.flight));
      } catch (e) {
        yield FlightsError();
      }
    }
  }
}
