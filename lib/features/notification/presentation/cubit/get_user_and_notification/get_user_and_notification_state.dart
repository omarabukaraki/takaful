part of 'get_user_and_notification_cubit.dart';

abstract class GetUserAndNotificationState {}

class GetUserAndNotificationInitial extends GetUserAndNotificationState {}

// ignore: must_be_immutable
class GetUserSuccess extends GetUserAndNotificationState {
  List<UserDetailsModel> userList;
  GetUserSuccess({required this.userList});
}

// ignore: must_be_immutable
class GetNotificationSuccess extends GetUserAndNotificationState {
  List<NotificationModel> notificationList;
  GetNotificationSuccess({required this.notificationList});
}

class GetUserAndNotificationLoading extends GetUserAndNotificationState {}

class GetUserAndNotificationFailure extends GetUserAndNotificationState {}
