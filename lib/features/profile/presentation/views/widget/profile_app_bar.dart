import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
    this.text,
    required this.image,
  });
  final String? text;
  final String image;
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
          text ?? '1010',
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
