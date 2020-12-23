import 'dart:async';

import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/services/airplane/dao/airplane_dao.dart';

class AirplaneRestDAO implements AirplaneDAO {

  @override
  Future<List<Airplane>> getAllAirplanes() {
    throw UnimplementedError();
  }

  @override
  Future<Airplane> createAirplane(Airplane airplane) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> deleteAirplane(Airplane airplane) {
    throw UnimplementedError();
  }
}