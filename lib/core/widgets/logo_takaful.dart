import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_assets.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';

class LogoTakaful extends StatelessWidget {
  const LogoTakaful({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        Text(AppString.textTakafulArabicName,
            style: TextStyle(fontSize: 51, color: AppColor.kPrimary)),
        Text(AppString.textTakafulEnglishName,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.kPrimary)),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAveLogo(image: AppAssets.assetsImageFoodlogin),
              CircleAveLogo(
                  image: AppAssets.assetsImageClotherss,
                  color: AppColor.kWhite),
              CircleAveLogo(image: AppAssets.assetsImageSofa),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

class CircleAveLogo extends StatelessWidget {
  const CircleAveLogo({
    this.color,
    required this.image,
    super.key,
  });
  final String image;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColor.kPrimary,
      radius: 27,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: color ?? AppColor.kPrimary,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
