import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:raf_airlines_admin/services/user/dao/user_dao.dart';

class UserService {

  final UserDAO dao;

  UserService({required this.dao});

  FutureOr<void> login(String username, String password) async => dao.login(username, password);
}