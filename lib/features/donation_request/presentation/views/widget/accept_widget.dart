import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';

class AcceptWidget extends StatelessWidget {
  const AcceptWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: AppColor.kGreen),
        child: const Center(
          child: Text(
            AppString.textAccepted,
            style: TextStyle(color: AppColor.kWhite),
          ),
        ));
  }
}
