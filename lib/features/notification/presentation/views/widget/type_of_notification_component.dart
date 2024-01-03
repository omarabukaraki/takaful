import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/notification/data/model/notification_model.dart';

class TypeOfNotificationComponent extends StatelessWidget {
  const TypeOfNotificationComponent({
    super.key,
    required this.notificationList,
  });

  final NotificationModel notificationList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 0))
        ],
        color: Colors.white,
      ),
      child: Center(
          child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(notificationList.titleNotification,
                      style: const TextStyle(
                          color: AppColor.kFont, fontWeight: FontWeight.bold)),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(notificationList.bodyNotification,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  Text(notificationList.acceptTime.substring(0, 16)),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.kPrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: notificationList.typeOfNotification == 'RPP'
                ? const Icon(
                    Icons.browser_not_supported,
                    size: 36,
                    color: AppColor.kWhite,
                  )
                : notificationList.typeOfNotification == 'SNFA'
                    ? const CircleAvatar(
                        backgroundColor: AppColor.kPrimary,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/image/logoTakaful.png')),
                      )
                    : notificationList.typeOfNotification == 'RRN'
                        ? const Icon(
                            Icons.close,
                            size: 36,
                            color: AppColor.kWhite,
                          )
                        : notificationList.typeOfNotification == 'APP'
                            ? const Icon(
                                Icons.art_track,
                                size: 36,
                                color: AppColor.kWhite,
                              )
                            : notificationList.typeOfNotification == 'DPN'
                                ? const Icon(
                                    Icons.delete,
                                    size: 36,
                                    color: AppColor.kWhite,
                                  )
                                : const SizedBox(),
          )),
        ],
      )),
    );
  }
}
