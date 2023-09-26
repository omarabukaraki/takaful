// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_donation_cubit.dart';

@immutable
abstract class AddDonationState {}

class AddDonationInitial extends AddDonationState {}

class AddDonationLodging extends AddDonationState {}

class AddDonationSuccess extends AddDonationState {}

class AddDonationFailure extends AddDonationState {}
