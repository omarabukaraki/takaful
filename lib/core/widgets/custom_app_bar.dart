import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.textOne,
    this.textTwo,
    this.onTap,
    this.sizeFont,
    required this.button,
    super.key,
  });
  final bool button;
  final VoidCallback? onTap;
  final String? textOne;
  final String? textTwo;
  final double? sizeFont;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // elevation: 0,
      // scrolledUnderElevation: 8,
      // shadowColor: Colors.grey.shade50,
      backgroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Column(children: [
        Text(
          textOne ?? 'ما الذي تود التبرع به',
          style: TextStyle(
            fontSize: sizeFont ?? 21,
            color: AppColor.kPrimary,
          ),
        ),
        Text(
          textTwo ?? 'اختر القسم المناسب لإضافة التبرع ',
          style: const TextStyle(
            fontSize: 10,
            color: AppColor.kFont,
            height: 1,
          ),
        )
      ]),
      actions: [
        button
            ? Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade200,
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 22,
                        color: AppColor.kPrimary,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
