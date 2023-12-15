import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  String? title = message.notification!.title;
  String? body = message.notification!.body;
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        displayOnForeground: true,
        displayOnBackground: true,
        id: 123,
        channelKey: 'call_channel',
        color: AppColor.kWhite,
        title: title,
        body: body,
        category: NotificationCategory.Message,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: AppColor.kPrimary),
  );
}

Future<bool> notificationInitialize() {
  return AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'call_channel',
        channelName: 'call_channel',
        channelDescription: 'channel of calling',
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        playSound: true,
        // onlyAlertOnce: true,
        defaultRingtoneType: DefaultRingtoneType.Notification)
  ]);
}

Future<void> changeUserToken() async {
  try {
    Future<String> getToken() async {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token == null) return '';
      return token;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'userToken': await getToken()});
  } catch (e) {
    e;
  }
}

void getForegroundNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String? title = message.notification!.title;
    String? body = message.notification!.body;
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 123,
          channelKey: 'call_channel',
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Message,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: AppColor.kPrimary),
    );
  });
}
