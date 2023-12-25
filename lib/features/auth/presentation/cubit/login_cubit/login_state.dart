part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLodging extends LoginState {}

// ignore: must_be_immutable
class LoginFailure extends LoginState {
  String errMessage;
  LoginFailure({required this.errMessage});
}

class ResetPasswordSuccess extends LoginState {}

// ignore: must_be_immutable
class ResetPasswordFailure extends LoginState {
  String errMessage;
  ResetPasswordFailure({required this.errMessage});
}
