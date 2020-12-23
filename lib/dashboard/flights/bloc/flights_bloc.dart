import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:raf_airlines_admin/services/flight/flight_service.dart';

part 'flights_event.dart';
part 'flights_state.dart';

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {

  final FlightService service;

  FlightsBloc({@required this.service}) : super(FlightsInitial());

  @override
  Stream<FlightsState> mapEventToState(FlightsEvent event) async* {
    // TODO: implement mapEventToState
  }
}
