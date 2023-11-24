import 'package:flutter/material.dart';

class ImageCountAndFullCount extends StatelessWidget {
  const ImageCountAndFullCount(
      {super.key, this.height, this.countImage, this.fullCountImage});
  final double? height;
  final int? countImage;
  final int? fullCountImage;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 62,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 122, 122, 122),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Expanded(
            flex: 3,
            child: Icon(
              Icons.image,
              size: 15,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                '$countImage / $fullCountImage',
                style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    overflow: TextOverflow.fade),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
