import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 8,
      shadowColor: Colors.grey.shade50,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Column(children: [
        const Text(
          'حسابي',
          style: TextStyle(
            fontSize: 21,
            color: AppColor.kPrimary,
          ),
        ),
        Text(
          FirebaseAuth.instance.currentUser!.email.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: AppColor.kFont,
            height: 1.5,
          ),
        )
      ]),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/image/user_image.png')),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
