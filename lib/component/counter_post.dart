import 'package:flutter/material.dart';

import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';

class CounterPost extends StatelessWidget {
  const CounterPost({
    super.key,
    required this.counter,
    required this.onTapAdd,
    required this.onTapRemove,
  });

  final int counter;
  final VoidCallback onTapAdd;
  final VoidCallback onTapRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.kTextFiled,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(onPressed: onTapAdd, icon: const Icon(Icons.add)),
        counter == 0
            ? const Text(
                AppString.textCounter,
                style: TextStyle(color: AppColor.kTextFiledFont),
              )
            : Text(counter.toString()),
        IconButton(onPressed: onTapRemove, icon: const Icon(Icons.remove)),
      ]),
    );
  }
}
