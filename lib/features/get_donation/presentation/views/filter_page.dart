import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'widget/filter_widget/body_of_botton_sheet.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 1.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColor.kTextFiled),
      child: const BodyOfBottomSheet(),
    );
  }
}
