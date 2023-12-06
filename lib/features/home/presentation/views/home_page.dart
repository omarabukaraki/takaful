import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:takaful/features/home/presentation/views/Modern_Elements_page.dart';
import 'package:takaful/features/home/presentation/views/keep_browsing_page.dart';
import 'package:takaful/features/home/presentation/views/widget/ad_post.dart';
import 'package:takaful/core/widgets/custom_search_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:takaful/core/utils/app_assets.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/get_category/presentation/views/items_type_page.dart';
import 'package:takaful/features/get_category/presentation/views/service_type_page.dart';
import '../../../notification/presentation/views/notifcation_page.dart';
import 'widget/ad_application.dart';
import 'widget/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int inIndex = 0;
  List<String> images = [
    'assets/image/ads_photo_one.png',
    'assets/image/ads_photo_two.png',
    'assets/image/ads_photo_three.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 8,
        shadowColor: Colors.grey.shade50,
        backgroundColor: AppColor.kWhite,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, NotificationPage.id);
          },
          icon: const Icon(Icons.notifications_rounded, size: 30),
          color: AppColor.kPrimary,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppString.textTakafulArabicName,
                  style: TextStyle(
                      fontSize: 28, color: AppColor.kPrimary, height: 1),
                ),
                Text(
                  AppString.textTakafulEnglishName,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColor.kGrey,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: CustomSearchBar(
                  icon: Icon(Icons.search),
                  hintText: AppString.textSearchInTakaful),
            ),
            CarouselSlider.builder(
              // carouselController: _controller,
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return AdApplication(
                  image: images[index],
                );
              },
              options: CarouselOptions(
                height: screenWidth < 500 ? 200 : 400,
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
                mainAxisAlignment: screenWidth < 500
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
      ),
    );
  }
}
