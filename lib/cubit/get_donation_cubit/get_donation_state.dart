part of 'get_donation_cubit.dart';

@immutable
abstract class GetDonationState {}

class GetDonationInitial extends GetDonationState {}

// ignore: must_be_immutable
class GetDonationSuccess extends GetDonationState {
  List<PostModel> posts = [];
  GetDonationSuccess({required this.posts});
}

class GetDonationLodging extends GetDonationState {}

class GetDonationFailure extends GetDonationState {}
