import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class LocationLoadingIndicator extends StatelessWidget {
  const LocationLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.kTextFiled),
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
