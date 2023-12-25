import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_colors.dart';

import '../../../../auth/data/model/user_details_model.dart';
import '../../../../profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import '../../../data/model/notification_model.dart';
import '../helper/custom_dialog.dart';

class NotificationComponent extends StatefulWidget {
  const NotificationComponent(
      {Key? key, required this.index, required this.notificationData})
      : super(key: key);

  final int index;
  final NotificationModel notificationData;

  @override
  State<NotificationComponent> createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  List<UserDetailsModel> users = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
      listener: (context, state) {
        if (state is GetUserDetailsSuccessForDonation) {
          users.add(state.user);
        } else if (state is GetUserDetailsLoadingForDonation) {
          // users = [];
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.notificationData.titleNotification,
                            style: const TextStyle(
                                fontSize: 15,
                                color: AppColor.kFont,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.notificationData.bodyNotification,
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColor.kFont,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        //end title
                        const Expanded(child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: Text(
                              'صاحب الإعلان '
                              ':'
                              ' ${users.length > widget.index ? users[widget.index].name : ''}',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColor.kFont,
                                  overflow: TextOverflow.ellipsis)),
                        ),
                        const Expanded(child: SizedBox()),

                        Expanded(
                            flex: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //start button accept and reject
                                Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        customDialog(
                                                context,
                                                users[widget.index]
                                                    .mobileNumber)
                                            .show();
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColor.kPrimary,
                                          border: Border.all(
                                              color: AppColor.kPrimary),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'اتصال',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    )),
                                //end button accept and reject

                                const SizedBox(width: 5),

                                //start display time of notification
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.notificationData.acceptTime
                                        .substring(0, 16),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                //end display time of notification
                              ],
                            )),
                      ]),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(users.length >
                                  widget.index
                              ? users[widget.index].image
                              : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f'),
                          fit: BoxFit.cover),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 1))
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
