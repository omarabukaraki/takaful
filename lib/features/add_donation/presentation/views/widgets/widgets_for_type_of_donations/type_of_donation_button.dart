import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class TypeOfDonationButton extends StatelessWidget {
  const TypeOfDonationButton(
      {super.key, this.onTap, this.text, this.typeOfDonation});

  final void Function()? onTap;
  final String? text;
  final String? typeOfDonation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 62,
        decoration: BoxDecoration(
            border: typeOfDonation == text
                ? Border.all(color: AppColor.kPrimary, width: 2)
                : Border.all(color: AppColor.kTextFiled, width: 0),
            borderRadius: BorderRadius.circular(20),
            color: AppColor.kTextFiled),
        child: Center(
            child: Text(text ?? 'مطلوب',
                style: const TextStyle(color: AppColor.kTextFiledFont))),
      ),
    );
  }
}
