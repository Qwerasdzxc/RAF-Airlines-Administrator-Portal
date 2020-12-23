import 'dart:async';
import 'dart:math';

import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/services/airplane/dao/airplane_dao.dart';

class AirplaneMockDAO implements AirplaneDAO {

  final List<Airplane> planes = [
    Airplane(id: 1, capacity: 366, name: "Boeing 747"),
    Airplane(id: 2, capacity: 242, name: "Boeing 787")
  ];

  @override
  Future<List<Airplane>> getAllAirplanes() async {
    await Future.delayed(Duration(milliseconds: 500));

    return List.from(planes);
  }

  @override
  Future<Airplane> createAirplane(Airplane airplane) async {
    await Future.delayed(Duration(milliseconds: 500));

    planes.add(airplane.copyWith(id: Random().nextInt(1000)));

    return planes.last;
  }

  @override
  FutureOr<void> deleteAirplane(Airplane airplane) async {
    await Future.delayed(Duration(milliseconds: 500));

    planes.remove(airplane);
  }
}