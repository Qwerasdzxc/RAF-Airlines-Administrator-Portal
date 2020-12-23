import 'dart:async';

import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/services/flight/dao/flight_dao.dart';

class FlightRestDAO implements FlightDAO {
  @override
  Future<List<Flight>> getAllFlights() {
    throw UnimplementedError();
  }

  @override
  Future<Flight> createFlight(Flight flight) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> deleteFlight(Flight flight) {
    throw UnimplementedError();
  }
}