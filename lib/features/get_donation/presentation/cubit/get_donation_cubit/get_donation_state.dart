part of 'get_donation_cubit.dart';

abstract class GetDonationState {}

class GetDonationInitial extends GetDonationState {}

// ignore: must_be_immutable
class GetDonationSuccess extends GetDonationState {
  List<DonationModel> donations = [];
  List<String> docId = [];
  GetDonationSuccess({required this.donations, required this.docId});
}

class GetDonationLodging extends GetDonationState {}

class GetDonationFailure extends GetDonationState {}
