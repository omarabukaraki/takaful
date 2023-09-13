import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {super.key,
      this.hintText,
      this.onChanged,
      this.typeText = false,
      this.icon,
      this.typeKeyboardNumber});
  final String? hintText;
  final Function(String)? onChanged;
  final bool typeText;
  final Icon? icon;
  final bool? typeKeyboardNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        // ignore: body_might_complete_normally_nullable
        validator: (data) {
          if (data!.isEmpty) {
            return 'الحقل مطلوب'.padLeft(86);
          }
        },

        keyboardType: typeKeyboardNumber == true
            ? TextInputType.number
            : TextInputType.text,
        obscureText: typeText,
        onChanged: onChanged,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          suffixIcon: icon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 117, 117, 117),
            fontSize: 15,
          ),
          filled: true,
          fillColor: const Color(0xffF2F2F2),
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
