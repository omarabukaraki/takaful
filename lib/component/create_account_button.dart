import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Text(AppString.textCreateAccountArabic,
              style: TextStyle(fontSize: 14, color: AppColor.kPrimary)),
        ),
        const Text(AppString.textDoNotHaveAccount,
            style: TextStyle(color: AppColor.kFontSecondary)),
      ],
    );
  }
}
