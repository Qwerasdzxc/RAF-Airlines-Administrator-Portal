import 'dart:async';

import 'package:raf_airlines_admin/models/airplane.dart';

abstract class AirplaneDAO {

  Future<List<Airplane>?> getAllAirplanes();

  Future<Airplane> createAirplane(Airplane airplane);

  FutureOr<void> deleteAirplane(Airplane airplane);
}