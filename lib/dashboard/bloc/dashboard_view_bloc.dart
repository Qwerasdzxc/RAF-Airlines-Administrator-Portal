import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raf_airlines_admin/dashboard/airplanes/airplanes_tab.dart';
import 'package:raf_airlines_admin/dashboard/airplanes/bloc/airplanes_bloc.dart';
import 'package:raf_airlines_admin/dashboard/airplanes/new_airplane/new_airplane_tab.dart';
import 'package:raf_airlines_admin/dashboard/bloc/tab_view.dart';
import 'package:raf_airlines_admin/dashboard/flights/bloc/flights_bloc.dart';
import 'package:raf_airlines_admin/dashboard/flights/flights_tab.dart';
import 'package:raf_airlines_admin/dashboard/flights/new_flight/new_flight_tab.dart';
import 'package:raf_airlines_admin/services/airplane/airplane_service.dart';
import 'package:raf_airlines_admin/services/flight/flight_service.dart';
import 'package:raf_airlines_admin/services/service_provider.dart';
import 'package:raf_airlines_admin/dashboard/views/tabbed_view.dart';

part 'dashboard_view_event.dart';
part 'dashboard_view_state.dart';

class DashboardViewBloc extends Bloc<DashboardViewEvent, DashboardViewState> {
  DashboardViewBloc() : super(HomeViewState());

  @override
  Stream<DashboardViewState> mapEventToState(DashboardViewEvent event) async* {
    if (event is HomeView)
      yield HomeViewState();
    else if (event is AirplanesView)
      yield AirplanesPageViewState(views: [
        TabView(tab: Tab(text: "All airplanes"), view: AirplanesTab()),
        TabView(tab: Tab(text: "New airplane"), view: NewAirplaneTab())
      ]);
    else if (event is FlightsView)
      yield FlightsPageViewState(views: [
        TabView(tab: Tab(text: "All flights"), view: FlightsTab()),
        TabView(tab: Tab(text: "New flight"), view: NewFlightTab())
      ]);
    else
      yield ErrorViewState();
  }
}
