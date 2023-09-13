// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:takaful/component/ad_post.dart';
import 'package:takaful/component/custom_search_bar.dart';
import 'package:takaful/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:takaful/view/items_page/items_type_page.dart';
import 'package:takaful/view/notifcation_page.dart';
import 'package:takaful/view/servives_pages/service_type_page.dart';
import '../../component/ads_screen.dart';
import '../../component/category.dart';

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
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, NotificationPage.id);
          },
          icon: const Icon(Icons.notifications_rounded, size: 30),
          color: kPrimary,
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
                  'تكافل',
                  style: TextStyle(fontSize: 28, color: kPrimary, height: 1),
                ),
                Text(
                  'Takaful',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
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
                  icon: Icon(Icons.search), hintText: 'ابحث في تكافل'),
            ),
            CarouselSlider.builder(
              // carouselController: _controller,
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return Ad(
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
                  const Category(
                    image: 'assets/image/Untitled-2.png',
                    text: 'جميع الأقسام',
                    radiusTwo: 30,
                  ),
                  Category(
                    image: 'assets/image/services_image.png',
                    text: 'الخدمات',
                    onTap: () {
                      Navigator.pushNamed(context, ServiceTypePage.id,
                          arguments: 'الخدمات');
                    },
                  ),
                  Category(
                    image: 'assets/image/items_image.png',
                    text: 'الاستهلاكيات',
                    onTap: () {
                      Navigator.pushNamed(context, ItemTypePage.id,
                          arguments: 'الاستهلاكيات');
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Column(
              children: [
                AdPosts(
                  headerText: 'العناصر الحديثة',
                  image: 'assets/image/ui.png',
                  ratingNumber: '4.8',
                  titlePost: 'وجبة لشخص صالحة لمدة يوم',
                ),
                SizedBox(
                  height: 20,
                ),
                AdPosts(
                  headerText: 'استمر في التصفح',
                  image: 'assets/image/K13.png',
                  titlePost: 'ملابس أطفال لعمر ثلاثة سنوات',
                  ratingNumber: '4.3',
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
