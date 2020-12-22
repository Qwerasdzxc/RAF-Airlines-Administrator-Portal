import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/services/flight/dao/flight_dao.dart';

class FlightRestDAO implements FlightDAO {
  @override
  Future<List<Flight>> getAllFlights() {
    throw UnimplementedError();
  }
}