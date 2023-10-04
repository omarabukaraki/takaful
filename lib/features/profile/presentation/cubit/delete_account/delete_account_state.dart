part of 'delete_account_cubit.dart';

@immutable
abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {}

// ignore: must_be_immutable
class DeleteAccountFailure extends DeleteAccountState {
  String errMessage;
  DeleteAccountFailure({required this.errMessage});
}
