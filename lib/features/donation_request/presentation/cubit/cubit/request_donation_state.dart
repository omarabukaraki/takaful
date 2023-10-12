part of 'request_donation_cubit.dart';

@immutable
abstract class RequestDonationState {}

class RequestDonationInitial extends RequestDonationState {}

// ignore: must_be_immutable
class RequestDonationSuccess extends RequestDonationState {
  List<RequestDonationModel> requests;
  List<String> requestId = [];
  RequestDonationSuccess({required this.requests, required this.requestId});
}

class RequestDonationLoading extends RequestDonationState {}

class RequestDonationFailure extends RequestDonationState {}
