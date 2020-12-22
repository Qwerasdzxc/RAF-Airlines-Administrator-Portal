part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccessful extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {}