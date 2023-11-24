// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_donation_request_cubit.dart';

@immutable
abstract class GetDonationRequestState {}

class GetDonationRequestInitial extends GetDonationRequestState {}

// ignore: must_be_immutable
class GetDonationRequestSuccess extends GetDonationRequestState {
  List<RequestDonationModel> requests;
  List<String> requestId = [];
  GetDonationRequestSuccess({
    required this.requests,
    required this.requestId,
  });
}

class GetDonationRequestFailure extends GetDonationRequestState {}

class GetDonationRequestLoading extends GetDonationRequestState {}

// ignore: must_be_immutable
class GetPostSuccess extends GetDonationRequestState {
  List<DonationModel> donationList = [];
  GetPostSuccess({required this.donationList});
}
