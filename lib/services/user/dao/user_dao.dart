import 'dart:async';

abstract class UserDAO {

  FutureOr<void> login(String username, String password);
}