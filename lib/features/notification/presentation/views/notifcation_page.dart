import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import '../../data/model/notification_model.dart';
import '../cubit/notification_cubit/notification_cubit.dart';
import 'widget/notification_component.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  static String id = 'NotificationPage';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    BlocProvider.of<NotificationCubit>(context).getNotification();
    super.initState();
  }

  List<NotificationModel> notificationData = [];
  bool isLoading = true;

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
        body: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationLoading) {
              isLoading = true;
            } else if (state is NotificationSuccess) {
              notificationData = state.notificationData;
              isLoading = false;
            } else if (state is NotificationFailure) {
              isLoading = false;
            }
          },
          builder: (context, state) {
            return ListView.builder(
              itemCount: notificationData.length,
              itemBuilder: (context, index) => isLoading != true
                  ? notificationProcess(
                      index: index,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          },
        ));
  }

  Widget notificationProcess({required int index}) {
    BlocProvider.of<GetUserDetailsCubit>(context)
        .userDonationInformation(email: notificationData[index].donarEmail);
    return notificationData[index].userId ==
                FirebaseAuth.instance.currentUser!.uid ||
            notificationData[index].userId == '0'
        ? NotificationComponent(
            index: index,
            notificationData: notificationData[index],
          )
        : const SizedBox();
  }
}
