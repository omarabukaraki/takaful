import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/notification/presentation/cubit/get_user_and_notification/get_user_and_notification_cubit.dart';
import 'package:takaful/features/notification/presentation/views/widget/notification_component.dart';
import '../../data/model/notification_model.dart';
import 'widget/type_of_notification_component.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  static String id = 'NotificationPage';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    BlocProvider.of<GetUserAndNotificationCubit>(context)
        .getUsersAndNotification();
    super.initState();
  }

  bool isLoading = false;
  List<NotificationModel> notificationList = [];
  List<UserDetailsModel> userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          button: true,
          textOne: 'الاشعارات',
          textTwo: '',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: BlocConsumer<GetUserAndNotificationCubit,
            GetUserAndNotificationState>(
          listener: (context, state) {
            if (state is GetNotificationSuccess) {
              notificationList = state.notificationList;
            } else if (state is GetUserSuccess) {
              userList = state.userList;
              isLoading = false;
            } else if (state is GetUserAndNotificationLoading) {
              isLoading = true;
            } else if (state is GetUserAndNotificationFailure) {
              isLoading = false;
            }
          },
          builder: (context, state) {
            return notificationList.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => FirebaseAuth
                                    .instance.currentUser!.uid ==
                                notificationList[index].userId ||
                            notificationList[index].userId == 'all'
                        ? notificationList[index].typeOfNotification == 'ARN'
                            ? NotificationComponent(
                                notificationList: notificationList[index],
                                userList: userList[index],
                              )
                            : TypeOfNotificationComponent(
                                notificationList: notificationList[index])
                        : const SizedBox(),
                    itemCount: userList.length,
                  )
                : const SizedBox();
          },
        ));
  }
}
