import 'dart:async';

import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/network/network_exception.dart';
import 'package:raf_airlines_admin/network/rest_client.dart';
import 'package:raf_airlines_admin/services/flight/dao/flight_dao.dart';

class FlightRestDAO implements FlightDAO {
  @override
  Future<List<Flight>?> getAllFlights() async {
    try {
      List<Flight>? flights = await RestClient().getAllFlights();
      return flights;
    } on NetworkException catch (e) {
      throw e;
    }
  }

  @override
  Future<Flight> createFlight(Flight flight) async {
    try {
      Flight result = await RestClient().createFlight(flight);
      return result;
    } on NetworkException catch (e) {
      throw e;
    }
  }

  @override
  FutureOr<void> deleteFlight(Flight flight) async {
    try {
      await RestClient().deleteFlight(flight);
    } on NetworkException catch (e) {
      throw e;
    }
  }
}