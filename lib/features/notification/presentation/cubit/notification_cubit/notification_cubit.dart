import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/notification/data/model/notification_model.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  CollectionReference notification =
      FirebaseFirestore.instance.collection('notification');
  Future<void> addNotification(
      {required String userId,
      required String typeOfNotification,
      required String acceptTime,
      required String donarEmail,
      required String titleNotification,
      required String bodyNotification}) async {
    await notification.add({
      'titleNotification': titleNotification,
      'bodyNotification': bodyNotification,
      'userId': userId,
      'typeOfNotification': typeOfNotification,
      'acceptTime': acceptTime,
      'donarEmail': donarEmail,
    });
  }
}
