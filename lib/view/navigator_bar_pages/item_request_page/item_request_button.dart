import 'package:flutter/material.dart';
import 'package:takaful/constant.dart';

class ItemRequestButton extends StatelessWidget {
  const ItemRequestButton({
    super.key,
    this.nameButton,
    this.colorAndBorder,
    this.onTap,
  });
  final String? nameButton;
  final bool? colorAndBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: colorAndBorder == true ? kPrimary : Colors.white,
          border: Border.all(color: kPrimary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          nameButton ?? 'رفض',
          style: TextStyle(
              color: colorAndBorder == true ? Colors.white : kPrimary),
        )),
      ),
    );
  }
}
