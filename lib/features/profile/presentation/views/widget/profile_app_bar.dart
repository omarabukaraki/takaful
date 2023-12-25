import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar(
      {super.key, this.text, required this.image, required this.isVerified});
  final String? text;
  final String image;
  final bool isVerified;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 8,
      shadowColor: Colors.grey.shade50,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'حسابي',
              style: TextStyle(
                fontSize: 21,
                color: AppColor.kPrimary,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isVerified == true
                    ? const Icon(Icons.verified, color: Colors.blue, size: 16)
                    : const SizedBox(),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  text ?? 'الاسم',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.kFont,
                    height: 1.5,
                  ),
                )
              ],
            )
          ]),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                image: CachedNetworkImageProvider(image),
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              )),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
