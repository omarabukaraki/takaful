import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import '../../../../auth/data/model/user_details_model.dart';
import '../../../data/model/notification_model.dart';
import '../helper/custom_dialog.dart';

class NotificationComponent extends StatelessWidget {
  const NotificationComponent(
      {Key? key, required this.notificationList, required this.userList})
      : super(key: key);

  final NotificationModel notificationList;
  final UserDetailsModel userList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    notificationList.titleNotification,
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
                    notificationList.bodyNotification,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      userList.isVerified
                          ? const Icon(Icons.verified,
                              color: Colors.blue, size: 16)
                          : const SizedBox(),
                      const SizedBox(width: 5),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                            'صاحب الإعلان '
                            ':'
                            '${userList.name}',
                            style: const TextStyle(
                                fontSize: 11,
                                color: AppColor.kFont,
                                overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  ),
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
                                customDialog(context, userList.mobileNumber)
                                    .show();
                              },
                              child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColor.kPrimary,
                                  border: Border.all(color: AppColor.kPrimary),
                                  borderRadius: BorderRadius.circular(20),
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
                            notificationList.acceptTime.substring(0, 16),
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
                margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(userList.image),
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
  }
}
