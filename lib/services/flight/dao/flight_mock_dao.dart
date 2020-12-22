import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/services/flight/dao/flight_dao.dart';

class FlightMockDAO implements FlightDAO {
  final List<Flight> flights = [
    Flight(
        id: 1,
        distance: 1690,
        airplane: Airplane(id: 1, capacity: 366, name: "Boeing 747"),
        startDestination: "BEG",
        endDestination: "LHR",
        price: 425,
        canceled: false),
    Flight(
        id: 2,
        distance: 1723,
        airplane: Airplane(id: 1, capacity: 366, name: "Boeing 747"),
        startDestination: "ZRH",
        endDestination: "LIS",
        price: 275,
        canceled: false),
  ];

  @override
  Future<List<Flight>> getAllFlights() {
    // TODO: implement getAllFlights
    throw UnimplementedError();
  }
}
