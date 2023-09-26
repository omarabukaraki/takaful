import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplayed extends StatelessWidget {
  const ImageDisplayed({
    super.key,
    required this.image,
  });

  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 164,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 4, offset: Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: FileImage(image), fit: BoxFit.cover)),
    );
  }
}
