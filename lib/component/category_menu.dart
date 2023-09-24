import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({
    required this.image,
    required this.text,
    this.onTap,
    super.key,
  });
  final String text;
  final String image;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 18, bottom: 10, top: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 12,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.kFont,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 28,
                left: 10,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColor.kPrimary,
                    ),
                  ),
                )),
            Positioned(
              right: 5,
              top: 10,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 2),
                          blurRadius: 10)
                    ]),
                width: 80,
                height: 80,
                child: Image(
                  image: CachedNetworkImageProvider(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
