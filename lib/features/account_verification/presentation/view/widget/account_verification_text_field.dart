import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../profile/presentation/views/widget/widget_manage_profile/text_field.dart';

class AccountVerificationTextField extends StatelessWidget {
  const AccountVerificationTextField({
    super.key,
    this.hintText,
    this.label,
    this.readOnly,
  });
  final String? label;
  final String? hintText;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Text(
            label ?? 'الاسم',
            style: const TextStyle(color: AppColor.kPrimary),
          ),
        ),
        ManageProfileTextField(
          hintText: hintText ?? 'الاسم',
          readOnly: readOnly ?? true,
        ),
      ],
    );
  }
}
