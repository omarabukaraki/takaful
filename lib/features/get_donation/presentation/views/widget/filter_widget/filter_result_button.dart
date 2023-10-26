import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class FilterResultButton extends StatelessWidget {
  const FilterResultButton({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.kPrimary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColor.kPrimary,
              ),
              Text(
                'فلترة النتائج',
                style: TextStyle(fontSize: 16, color: AppColor.kPrimary),
              ),
              Icon(Icons.filter_alt_rounded, color: AppColor.kPrimary)
            ]),
      ),
    );
  }
}
