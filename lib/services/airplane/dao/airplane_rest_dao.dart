import 'dart:async';

import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/network/network_exception.dart';
import 'package:raf_airlines_admin/network/rest_client.dart';
import 'package:raf_airlines_admin/services/airplane/dao/airplane_dao.dart';

class AirplaneRestDAO implements AirplaneDAO {

  @override
  Future<List<Airplane>?> getAllAirplanes() async {
    try {
      List<Airplane>? airplanes = await RestClient().getAllAirplanes();
      return airplanes;
    } on NetworkException catch (e) {
      throw e;
    }
  }

  @override
  Future<Airplane> createAirplane(Airplane airplane) async {
    try {
      Airplane result = await RestClient().createAirplane(airplane);
      return result;
    } on NetworkException catch (e) {
      throw e;
    }
  }

  @override
  FutureOr<void> deleteAirplane(Airplane airplane) async {
    try {
      await RestClient().deleteAirplane(airplane);
    } on NetworkException catch (e) {
      throw e;
    }
  }
}