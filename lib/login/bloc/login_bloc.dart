import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:raf_airlines_admin/services/user/user_service.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService? userService;

  LoginBloc({required this.userService}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginCredentialsProvided) {
      yield LoginLoading();

      try {
        await userService!.login(event.username, event.password);

        yield LoginSuccessful();
      } catch (_) {
        yield LoginError();
      }
    }
  }
}
