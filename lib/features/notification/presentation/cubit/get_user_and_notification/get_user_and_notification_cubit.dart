import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/notification/data/model/notification_model.dart';

part 'get_user_and_notification_state.dart';

class GetUserAndNotificationCubit extends Cubit<GetUserAndNotificationState> {
  GetUserAndNotificationCubit() : super(GetUserAndNotificationInitial());

  CollectionReference notification =
      FirebaseFirestore.instance.collection('notification');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void getUsersAndNotification() {
    emit(GetUserAndNotificationLoading());
    try {
      notification
          .orderBy('acceptTime', descending: true)
          .snapshots()
          .listen((event) {
        List<NotificationModel> notificationList = [];
        List<UserDetailsModel> userList = [];
        for (var doc in event.docs) {
          users.snapshots().listen((event) {
            for (var element in event.docs) {
              if (element['email'] == doc['donarEmail']) {
                notificationList.add(NotificationModel.fromJson(doc));
                userList.add(UserDetailsModel.fromJson(element));
              }
            }
            emit(GetUserSuccess(userList: userList));
          });
          emit(GetNotificationSuccess(notificationList: notificationList));
        }
      });
    } catch (e) {
      emit(GetUserAndNotificationFailure());
    }
  }
}
