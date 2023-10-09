import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColor.kPrimary),
        child: const Center(
            child: Text(
          'طلب',
          style: TextStyle(
            fontSize: 16,
            color: AppColor.kWhite,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
