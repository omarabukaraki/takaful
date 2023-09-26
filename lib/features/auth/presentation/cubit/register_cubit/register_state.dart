part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterLodging extends RegisterState {}

// ignore: must_be_immutable
class RegisterFailure extends RegisterState {
  String errMassage;
  RegisterFailure({required this.errMassage});
}
