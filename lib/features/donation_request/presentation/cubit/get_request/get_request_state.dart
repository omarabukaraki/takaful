// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_request_cubit.dart';

@immutable
abstract class GetRequestState {}

class GetRequestInitial extends GetRequestState {}

// ignore: must_be_immutable
class GetRequestSuccess extends GetRequestState {
  List<RequestDonationModel> requests;
  List<String> requestId;
  GetRequestSuccess({required this.requests, required this.requestId});
}

class GetRequestLoading extends GetRequestState {}

class GetRequestFailure extends GetRequestState {}
