import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.kTextFiled,
        ),
        child: const Center(
          child: Text(
            'تغيير كلمة المرور',
            style: TextStyle(
              color: AppColor.kTextFiledFont,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
