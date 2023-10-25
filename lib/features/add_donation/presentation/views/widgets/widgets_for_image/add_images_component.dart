import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class AddImagesComponent extends StatelessWidget {
  const AddImagesComponent(
      {super.key,
      this.textOne,
      this.textTwo,
      this.isOneText,
      this.iconSize,
      this.fontSize});
  final String? textOne;
  final String? textTwo;
  final bool? isOneText;
  final double? iconSize;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 164,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: AppColor.kGrey, blurRadius: 5, offset: Offset(0, 2))
      ], borderRadius: BorderRadius.circular(20), color: AppColor.kPrimary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            size: iconSize ?? 40,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            textOne ?? 'الصورة الرئيسية',
            style: TextStyle(color: AppColor.kWhite, fontSize: fontSize ?? 14),
          ),
          isOneText != true
              ? Text(textTwo ?? '(مطلوب)',
                  style: const TextStyle(color: AppColor.kWhite, fontSize: 12))
              : const SizedBox()
        ],
      ),
    );
  }
}
