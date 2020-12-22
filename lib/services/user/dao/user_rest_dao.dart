import 'dart:async';

import 'package:raf_airlines_admin/network/network_exception.dart';
import 'package:raf_airlines_admin/network/rest_client.dart';
import 'package:raf_airlines_admin/services/user/dao/user_dao.dart';

class UserRestDAO implements UserDAO {
  @override
  FutureOr<void> login(String username, String password) async {
    try {
      await RestClient().login(username, password);
    } on NetworkException catch (e) {
      print(e.cause);
      throw e;
    }
  }
}