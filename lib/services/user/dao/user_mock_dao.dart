import 'dart:async';

import 'package:raf_airlines_admin/network/network_exception.dart';
import 'package:raf_airlines_admin/services/user/dao/user_dao.dart';

class UserMockDAO implements UserDAO {

  final String username = "admin";
  final String password = "admin";

  @override
  FutureOr<void> login(String username, String password) {
    if (this.username != username || this.password != password)
      throw NetworkException(cause: "Invalid credentials");
  }
}