import 'package:flutter/material.dart';
import 'package:takaful/constant.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.screenHeigth,
      this.onTap});

  final double screenHeigth;
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: screenHeigth / 11,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: .5, color: Color(0xffD1D1D1)))),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: kFont),
          ),
          const SizedBox(
            width: 15,
          ),
          Icon(icon, size: 30, color: kPrimary)
        ]),
      ),
    );
  }
}
