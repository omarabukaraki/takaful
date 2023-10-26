import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.kPrimary)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('الترتيب',
                style: TextStyle(fontSize: 16, color: AppColor.kPrimary)),
            Icon(Icons.swap_vert_rounded, color: AppColor.kPrimary)
          ],
        ),
      ),
    );
  }
}
