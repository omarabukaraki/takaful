import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class AlertDialogButton extends StatelessWidget {
  const AlertDialogButton({Key? key, this.titleButton, this.onTap, this.color})
      : super(key: key);
  final String? titleButton;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? AppColor.kPrimary),
        child: Center(
            child: Text(titleButton ?? 'المعرض',
                style: const TextStyle(color: AppColor.kWhite))),
      ),
    );
  }
}
