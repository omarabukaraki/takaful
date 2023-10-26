import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';

class FilterButtonToBottomSheet extends StatelessWidget {
  const FilterButtonToBottomSheet({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 60),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.kPrimary, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: AppColor.kPrimary),
        child: const Center(
          child: Text(
            'فلترة',
            style: TextStyle(color: AppColor.kWhite, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
