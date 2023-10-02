import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/text_field.dart';

class EditTextField extends StatelessWidget {
  const EditTextField(
      {super.key,
      required this.readOnly,
      this.onTap,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.controller});

  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Text(
              labelText ?? 'label',
              style: const TextStyle(color: AppColor.kPrimary),
            ),
          ),
          Stack(alignment: const Alignment(1, -2), children: [
            ManageProfileTextField(
              controller: controller,
              onChanged: onChanged,
              hintText: hintText ?? 'الاسم',
              readOnly: readOnly,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.kPrimary),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    )),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
