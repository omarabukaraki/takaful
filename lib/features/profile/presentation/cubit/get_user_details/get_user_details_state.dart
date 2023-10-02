// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_user_details_cubit.dart';

@immutable
abstract class GetUserDetailsState {}

class GetUserDetailsInitial extends GetUserDetailsState {}

// ignore: must_be_immutable
class GetUserDetailsSuccess extends GetUserDetailsState {
  List<UserDetailsModel> user;
  GetUserDetailsSuccess({
    required this.user,
  });
}

class GetUserDetailsLoading extends GetUserDetailsState {}

class GetUserDetailsFailure extends GetUserDetailsState {}