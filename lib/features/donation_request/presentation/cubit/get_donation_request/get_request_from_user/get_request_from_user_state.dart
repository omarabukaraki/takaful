// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_request_from_user_cubit.dart';

@immutable
abstract class GetRequestFromUserState {}

class GetRequestFromUserInitial extends GetRequestFromUserState {}

// ignore: must_be_immutable
class GetRequestFromUserSuccess extends GetRequestFromUserState {
  List<RequestDonationModel> requests;
  List<String> requestId;
  GetRequestFromUserSuccess({required this.requests, required this.requestId});
}

class GetRequestFromUserLoading extends GetRequestFromUserState {}

class GetRequestFromUserFailure extends GetRequestFromUserState {}
