import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_assets.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/get_category/presentation/views/items_type_page.dart';
import 'package:takaful/features/get_category/presentation/views/service_type_page.dart';
import 'Modern_Elements_page.dart';
import 'keep_browsing_page.dart';
import 'widget/ad_component.dart';
import 'widget/ad_post.dart';
import 'widget/category.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AdComponent(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: widget.screenWidth < 500
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.spaceEvenly,
              children: [
                Category(
                  image: AppAssets.assetsImageUntitled2,
                  text: AppString.textAllCategory,
                  radiusTwo: 30,
                  onTap: () {},
                ),
                Category(
                  image: AppAssets.assetsImageServicesImage,
                  text: AppString.textServices,
                  onTap: () {
                    Navigator.pushNamed(context, ServiceTypePage.id,
                        arguments: AppString.textServices);
                  },
                ),
                Category(
                  image: AppAssets.assetsImageItemsImage,
                  text: AppString.textItems,
                  onTap: () {
                    Navigator.pushNamed(context, ItemTypePage.id,
                        arguments: AppString.textItems);
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          AdPosts(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ModernElementsPage();
                },
              ));
            },
            headerText: AppString.textModernElements,
            image: 'assets/image/ui.png',
            titlePost: 'وجبة لشخص صالحة لمدة يوم',
          ),
          const SizedBox(
            height: 20,
          ),
          AdPosts(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const KeepBrowsingPage();
                },
              ));
            },
            headerText: AppString.textKeepBrowsing,
            image: 'assets/image/K13.png',
            titlePost: 'ملابس أطفال لعمر ثلاثة سنوات',
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
