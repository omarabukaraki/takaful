import 'package:flutter/material.dart';

class ImageCount extends StatelessWidget {
  const ImageCount({
    this.countImage,
    this.height,
    super.key,
  });
  final double? height;
  final int? countImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 122, 122, 122),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Icon(
          Icons.image,
          size: 15,
          color: Colors.white,
        ),
        Text(
          countImage.toString(),
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
        )
      ]),
    );
  }
}
