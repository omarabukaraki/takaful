import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.kTextFiled),
        child: const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            'الموقع',
            style: TextStyle(
              color: AppColor.kTextFiledFont,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.location_on,
              color: AppColor.kFont,
            ),
          )
        ]),
      ),
    );
  }
}
