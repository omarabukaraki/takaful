import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class MyDonationRequestsButton extends StatelessWidget {
  const MyDonationRequestsButton({
    super.key,
    this.nameButton,
    this.colorAndBorder,
    this.onTap,
  });
  final String? nameButton;
  final bool? colorAndBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: colorAndBorder == true ? AppColor.kPrimary : Colors.white,
          border: Border.all(color: AppColor.kPrimary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          nameButton ?? 'رفض',
          style: TextStyle(
              color: colorAndBorder == true ? Colors.white : AppColor.kPrimary),
        )),
      ),
    );
  }
}
