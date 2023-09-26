import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key? key,
    this.onTap,
    this.textOne,
    this.textTwo,
  }) : super(key: key);
  final void Function()? onTap;
  final String? textOne;
  final String? textTwo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(textOne ?? AppString.textCreateAccountArabic,
              style: const TextStyle(fontSize: 14, color: AppColor.kPrimary)),
        ),
        Text(textTwo ?? AppString.textDoNotHaveAccount,
            style: const TextStyle(color: AppColor.kFontSecondary)),
      ],
    );
  }
}
