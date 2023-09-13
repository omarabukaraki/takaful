import 'package:flutter/material.dart';

class Ad extends StatelessWidget {
  const Ad({
    required this.image,
    super.key,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        // height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(image, fit: BoxFit.fill),
      ),
    );
  }
}
