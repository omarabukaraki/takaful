// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_user_details_cubit.dart';

abstract class GetUserDetailsState {}

class GetUserDetailsInitial extends GetUserDetailsState {}

class GetUserDetailsSuccess extends GetUserDetailsState {
  List<UserDetailsModel> user;
  GetUserDetailsSuccess({
    required this.user,
  });
}

class GetUserDetailsLoadingForDonation extends GetUserDetailsState {}

class GetUserDetailsSuccessForDonation extends GetUserDetailsState {
  UserDetailsModel user;
  GetUserDetailsSuccessForDonation({
    required this.user,
  });
}

class GetUserDetailsSuccessForRequestDonation extends GetUserDetailsState {
  List<UserDetailsModel> user;
  GetUserDetailsSuccessForRequestDonation({
    required this.user,
  });
}

class GetUserDetailsLoading extends GetUserDetailsState {}

class GetUserDetailsFailure extends GetUserDetailsState {}
