import 'package:raf_airlines_admin/models/flight.dart';

abstract class FlightDAO {
  Future<List<Flight>> getAllFlights();
}