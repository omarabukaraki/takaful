import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({super.key, this.icon, this.text, this.onTap});
  final IconData? icon;
  final String? text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
            color: AppColor.kPrimary, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.check,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 5),
            Text(
              text ?? 'تم اضافة الصور بنجاح',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
