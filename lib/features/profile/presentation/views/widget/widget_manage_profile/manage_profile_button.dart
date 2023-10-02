import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class ManageProfileButton extends StatelessWidget {
  const ManageProfileButton({
    super.key,
    this.color,
    this.text,
    this.onTap,
  });
  final Color? color;
  final String? text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? AppColor.kRed,
          ),
          child: Center(
            child: Text(
              text ?? 'حذف الحساب',
              style: const TextStyle(
                color: AppColor.kWhite,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
