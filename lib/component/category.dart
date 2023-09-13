import 'package:flutter/material.dart';
import 'package:takaful/constant.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.image,
    required this.text,
    this.radiusTwo,
    this.onTap,
  });
  final String image;
  final String text;
  final double? radiusTwo;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: const Color(0xffECECEC),
            child: CircleAvatar(
              backgroundColor: const Color(0xffECECEC),
              backgroundImage: AssetImage(image),
              radius: radiusTwo ?? 35,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: kFont,
              fontFamily: 'ElMessiri',
            ),
          ),
        ],
      ),
    );
  }
}
