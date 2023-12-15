// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../notification_cubit/notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

// ignore: must_be_immutable
class NotificationSuccess extends NotificationState {
  List<NotificationModel> notificationData;
  NotificationSuccess({
    required this.notificationData,
  });
}

class NotificationLoading extends NotificationState {}

class NotificationFailure extends NotificationState {}
