import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:takaful/core/utils/app_constants.dart';
import 'package:takaful/features/notification/presentation/cubit/notification_cubit/notification_cubit.dart';

part 'send_notification_state.dart';

class SendNotificationCubit extends Cubit<SendNotificationState> {
  SendNotificationCubit() : super(SendNotificationInitial());

  Future<void> sendPushNotification({
    required String title,
    required String body,
    required String token,
    required BuildContext context,
    required String userId,
    required String typeOfNotification,
    required String donarEmail,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=${Constant.constantServerKey}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': token,
            // 'token':
            //     'dIP1XcNPQS-zSuI9-BGUh9:APA91bE5jYcekN9SMtKkWFjCjmDz7IwEj1E5MSPgBSu7POAblqFCwGx7kgt-MWG23JqXfpi-C8rSsRgeptgX3yvspyCKr8OJkE2PPi-eUkaKZOAaDXXNNylLoiXDaHx4w_OeD5i0xNzE'
          },
        ),
      );
      response;
      // ignore: use_build_context_synchronously
      BlocProvider.of<NotificationCubit>(context).addNotification(
          titleNotification: title,
          bodyNotification: body,
          userId: userId,
          typeOfNotification: typeOfNotification,
          acceptTime: DateTime.now().toString(),
          donarEmail: donarEmail);
    } catch (e) {
      e;
    }
  }
}
