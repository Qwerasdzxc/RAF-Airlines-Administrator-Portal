import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/models/flight.dart';
import 'package:raf_airlines_admin/services/flight/dao/flight_dao.dart';

class FlightService {

  final FlightDAO dao;

  FlightService({@required this.dao});

  Future<List<Flight>> getAllFlights() async => dao.getAllFlights();
}