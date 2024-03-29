import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class AdPosts extends StatelessWidget {
  const AdPosts({
    required this.headerText,
    required this.image,
    this.titlePost,
    this.onTap,
    super.key,
  });
  final String image;
  final String headerText;
  final VoidCallback? onTap;
  final String? titlePost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'مشاهدة الكل',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.kPrimary,
                    ),
                  ),
                ),
                Text(
                  headerText,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.kFont,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fill)),
            width: double.infinity,
            height: 197,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              titlePost ?? 'وجبة لشخص صالحة لمدة يوم',
              style: const TextStyle(
                fontSize: 16,
                color: AppColor.kFont,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
