import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:takaful/core/utils/app_assets.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/get_category/presentation/views/items_type_page.dart';
import 'package:takaful/features/get_category/presentation/views/service_type_page.dart';
import 'Modern_Elements_page.dart';
import 'keep_browsing_page.dart';
import 'widget/ad_application.dart';
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
  int inIndex = 0;
  List<String> images = [
    'assets/image/ads_photo_one.png',
    'assets/image/ads_photo_two.png',
    'assets/image/ads_photo_three.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider.builder(
            // carouselController: _controller,

            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              return AdApplication(
                image: images[index],
              );
            },
            options: CarouselOptions(
              height: widget.screenWidth < 500 ? 200 : 400,
              onPageChanged: (index, reason) {
                setState(() {
                  inIndex = index;
                });
              },
              enlargeCenterPage: true,
              viewportFraction: 1,
              autoPlay: true,
              // reverse: true,
              autoPlayInterval: const Duration(seconds: 5),
            ),
          ),
          AnimatedSmoothIndicator(
              effect: const ExpandingDotsEffect(
                dotWidth: 9,
                dotHeight: 5,
                dotColor: Color(0xff7985CB),
              ),
              activeIndex: inIndex,
              count: images.length),
          const SizedBox(
            height: 20,
          ),
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
