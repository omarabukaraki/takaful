import 'package:flutter/material.dart';
import 'package:takaful/constant.dart';

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
        color: kTextFiled,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(onPressed: onTapAdd, icon: const Icon(Icons.add)),
        counter == 0
            ? const Text(
                'العدد',
                style: TextStyle(color: kTextFiledFont),
              )
            : Text(counter.toString()),
        IconButton(onPressed: onTapRemove, icon: const Icon(Icons.remove)),
      ]),
    );
  }
}
