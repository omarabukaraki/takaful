part of 'save_donation_cubit.dart';

@immutable
abstract class SaveDonationState {}

 class SaveDonationInitial extends SaveDonationState {}
 class SaveDonationSuccess extends SaveDonationState {

  List<SaveDonationModel> donationSaved =[];
  SaveDonationSuccess({required this.donationSaved});
 }
