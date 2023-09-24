import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key,
      this.hintText,
      this.onChanged,
      this.typeText = false,
      this.icon});
  final String? hintText;
  final Function(String)? onChanged;
  final bool typeText;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        // ignore: body_might_complete_normally_nullable
        validator: (data) {
          if (data!.isEmpty) {
            return 'الحقل مطلوب'.padLeft(100);
          }
        },
        obscureText: typeText,
        onChanged: onChanged,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 1),
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
      ),
    );
  }
}
