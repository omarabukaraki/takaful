import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/add_donation/presentation/views/add_donation.dart';
import 'package:takaful/features/donation_request/presentation/views/my_donation_requests_page.dart';
import '../../../profile/presentation/views/profile_page.dart';
import 'home_page.dart';

class NavigatorBarPage extends StatefulWidget {
  const NavigatorBarPage({super.key});
  static String id = 'NavigatorBarPage';
  @override
  State<NavigatorBarPage> createState() => _NavigatorBarPageState();
}

class _NavigatorBarPageState extends State<NavigatorBarPage> {
  int _currentIndex = 3;
  final screen = const [
    ProfilePage(),
    MyDonationRequests(),
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
          setState(() {
            _currentIndex = value;
          });
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
            label: 'أضف إعلان',
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
