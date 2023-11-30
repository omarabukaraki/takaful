part of 'edit_and_delete_donation_cubit.dart';

@immutable
abstract class EditAndDeleteDonationState {}

class EditAndDeleteDonationInitial extends EditAndDeleteDonationState {}

class EditDonationSuccess extends EditAndDeleteDonationState {}

class EditDonationLoading extends EditAndDeleteDonationState {}

class EditDonationFailure extends EditAndDeleteDonationState {}
