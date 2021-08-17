import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/services/flight/dao/flight_dao.dart';

class FlightService {

  final FlightDAO dao;

  FlightService({required this.dao});

  Future<List<Flight>?> getAllFlights() async => dao.getAllFlights();

  Future<Flight> createFlight(Flight flight) async => dao.createFlight(flight);

  FutureOr<void> deleteFlight(Flight flight) async => dao.deleteFlight(flight);
}