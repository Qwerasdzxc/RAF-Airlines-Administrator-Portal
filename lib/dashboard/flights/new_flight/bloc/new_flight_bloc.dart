import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/dashboard/flights/bloc/flights_bloc.dart';
import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/services/airplane/airplane_service.dart';
import 'package:raf_airlines_admin/services/flight/flight_service.dart';

part 'new_flight_event.dart';

part 'new_flight_state.dart';

class NewFlightBloc extends Bloc<NewFlightEvent, NewFlightState> {
  final FlightService? flightService;
  final AirplaneService? airplaneService;

  final FlightsBloc flightsBloc;

  NewFlightBloc(
      {required this.flightService, required this.airplaneService, required this.flightsBloc})
      : super(NewFlightLoading());

  @override
  Stream<NewFlightState> mapEventToState(NewFlightEvent event) async* {
    if (event is NewFlightInit) {
      yield NewFlightLoading();

      try {
        final airplanes = await airplaneService!.getAllAirplanes();

        yield NewFlightInitial(planes: airplanes);
      } catch (_) {
        yield NewFlightError(planes: []);
      }
    }
    if (event is NewFlightProvided) {
      if (event.airplane == null) {
        yield NewFlightError(planes: state.airplanes);
        return;
      }

      NewFlightState currState = state;

      yield NewFlightLoading();

      try {
        int distance = int.parse(event.distance);
        double price = double.parse(event.price);

        final flight = await flightService!.createFlight(Flight(
            airplane: event.airplane,
            price: price,
            distance: distance,
            startDestination: event.startDestination.toUpperCase(),
            endDestination: event.endDestination.toUpperCase()));

        flightsBloc.add(AddFlightEvent(flight: flight));

        yield NewFlightCreated(flight: flight, planes: currState.airplanes);

        await Future.delayed(Duration(seconds: 2));
        yield NewFlightInitial(planes: currState.airplanes);
      } catch (_) {
        yield NewFlightError(planes: currState.airplanes);
      }
    }
  }
}
