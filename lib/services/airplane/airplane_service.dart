import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/services/airplane/dao/airplane_dao.dart';

class AirplaneService {

  final AirplaneDAO dao;

  AirplaneService({@required this.dao});

  Future<List<Airplane>> getAllAirplanes() async => dao.getAllAirplanes();
}