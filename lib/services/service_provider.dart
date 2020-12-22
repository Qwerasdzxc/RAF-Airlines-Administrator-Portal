import 'package:get_it/get_it.dart';
import 'package:raf_airlines_admin/services/user/dao/user_mock_dao.dart';
import 'package:raf_airlines_admin/services/user/dao/user_rest_dao.dart';
import 'package:raf_airlines_admin/services/user/user_service.dart';

final getService = GetIt.instance;

void initRestServices() {
  getService.registerLazySingleton<UserService>(() => UserService(dao: UserRestDAO()));
}

void initMockServices() {
  getService.registerLazySingleton<UserService>(() => UserService(dao: UserMockDAO()));
}