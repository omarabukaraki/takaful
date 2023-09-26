import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.circular,
      this.color,
      this.textColor,
      required this.text,
      required this.onTap});
  final Color? color;
  final Color? textColor;
  final String text;
  final VoidCallback onTap;
  final double? circular;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.kPrimary),
              borderRadius: BorderRadius.circular(20),
              color: color),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 19,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
