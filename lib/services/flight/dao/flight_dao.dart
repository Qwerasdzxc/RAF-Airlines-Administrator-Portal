import 'dart:async';

import 'package:raf_airlines_admin/models/flight.dart';

abstract class FlightDAO {
  Future<List<Flight>> getAllFlights();

  Future<Flight> createFlight(Flight flight);

  FutureOr<void> deleteFlight(Flight flight);
}