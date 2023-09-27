import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class TextFieldForLocation extends StatelessWidget {
  const TextFieldForLocation({
    Key? key,
    this.hintText,
    this.onChanged,
    this.readOnly,
    this.icon,
    this.controller,
  }) : super(key: key);
  final String? hintText;
  final Function(String)? onChanged;
  final bool? readOnly;
  final Icon? icon;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if (data!.isEmpty) {
          return 'الحقل مطلوب'.padLeft(30);
        }
      },
      readOnly: readOnly ?? false,
      obscureText: false,
      controller: controller,
      onChanged: onChanged,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColor.kTextFiledFont,
          fontSize: 15,
        ),
        filled: true,
        fillColor: AppColor.kTextFiled,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
