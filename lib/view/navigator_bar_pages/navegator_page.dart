// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_donation.dart';
import 'package:takaful/view/navigator_bar_pages/item_request_page/item_request_page.dart';
import 'package:takaful/view/navigator_bar_pages/profile_page/profile_page.dart';
import 'home_page.dart';

class NavigatorBarPage extends StatefulWidget {
  const NavigatorBarPage({super.key});
  static String id = 'NavigatorBarPage';
  @override
  State<NavigatorBarPage> createState() => _NavigatorBarPageState();
}

class _NavigatorBarPageState extends State<NavigatorBarPage> {
  int inIndex = 0;
  int _currentIndex = 3;
  List<String> images = [
    'assets/image/801.png',
    'assets/image/banner_f4638420-4d69-47bb-bff4-83aad34e8f45.jpg',
    'assets/image/نماذج-التبرع_العربية-1013x441.png'
  ];
  final screen = const [
    ProfilePage(),
    ItemRequest(),
    AddDonation(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.kPrimary,
        unselectedItemColor: AppColor.kFont,
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          color: AppColor.kFont,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          color: AppColor.kFont,
        ),
        iconSize: 30,
        // fixedColor: Kprimary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {});
          _currentIndex = value;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded, color: AppColor.kPrimary),
            label: 'حسابي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded, color: AppColor.kPrimary),
            label: AppString.textItemRequest,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance, color: AppColor.kPrimary),
            label: 'أضف تبرع',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, color: AppColor.kPrimary),
            label: 'الرئيسية',
          ),
        ],
      ),
    );
  }
}
