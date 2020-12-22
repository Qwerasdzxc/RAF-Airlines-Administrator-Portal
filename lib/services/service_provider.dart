import 'package:get_it/get_it.dart';
import 'package:raf_airlines_admin/services/airplane/airplane_service.dart';
import 'package:raf_airlines_admin/services/airplane/dao/airplane_rest_dao.dart';
import 'package:raf_airlines_admin/services/flight/dao/flight_rest_dao.dart';
import 'package:raf_airlines_admin/services/flight/flight_service.dart';
import 'package:raf_airlines_admin/services/user/dao/user_mock_dao.dart';
import 'package:raf_airlines_admin/services/user/dao/user_rest_dao.dart';
import 'package:raf_airlines_admin/services/user/user_service.dart';

import 'airplane/dao/airplane_mock_dao.dart';
import 'flight/dao/flight_mock_dao.dart';

final getService = GetIt.instance;

void initRestServices() {
  getService.registerLazySingleton<UserService>(() => UserService(dao: UserRestDAO()));
  getService.registerLazySingleton<AirplaneService>(() => AirplaneService(dao: AirplaneRestDAO()));
  getService.registerLazySingleton<FlightService>(() => FlightService(dao: FlightRestDAO()));
}

void initMockServices() {
  getService.registerLazySingleton<UserService>(() => UserService(dao: UserMockDAO()));
  getService.registerLazySingleton<AirplaneService>(() => AirplaneService(dao: AirplaneMockDAO()));
  getService.registerLazySingleton<FlightService>(() => FlightService(dao: FlightMockDAO()));
}