part of 'add_image_to_verification_account_cubit.dart';

@immutable
abstract class AddImageToVerificationAccountState {}

class AddImageToVerificationAccountInitial
    extends AddImageToVerificationAccountState {}

class AddImageToVerificationAccountLoading
    extends AddImageToVerificationAccountState {}

// ignore: must_be_immutable
class AddImageToVerificationAccountSuccess
    extends AddImageToVerificationAccountState {
  String url;
  AddImageToVerificationAccountSuccess({required this.url});
}

class AddImageToVerificationAccountFailure
    extends AddImageToVerificationAccountState {}
