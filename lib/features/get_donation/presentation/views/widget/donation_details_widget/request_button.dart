import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({super.key, this.onTap, this.nameButton});
  final VoidCallback? onTap;
  final String? nameButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColor.kPrimary),
        child: Center(
            child: Text(
          nameButton ?? 'طلب',
          style: const TextStyle(
            fontSize: 16,
            color: AppColor.kWhite,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
