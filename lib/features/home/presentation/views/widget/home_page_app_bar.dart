import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/notification/presentation/views/notifcation_page.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // elevation: 0,
      // scrolledUnderElevation: 8,
      // shadowColor: Colors.grey.shade50,
      surfaceTintColor: AppColor.kWhite,
      backgroundColor: AppColor.kWhite,
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, NotificationPage.id);
        },
        icon: const Icon(Icons.notifications_rounded, size: 30),
        color: AppColor.kPrimary,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                AppString.textTakafulArabicName,
                style: TextStyle(
                    fontSize: 28, color: AppColor.kPrimary, height: 1),
              ),
              Text(
                AppString.textTakafulEnglishName,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColor.kGrey,
                    fontWeight: FontWeight.bold,
                    height: 1),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
