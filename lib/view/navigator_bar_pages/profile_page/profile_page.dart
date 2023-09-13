import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takaful/view/auth/login_page.dart';
import 'package:takaful/view/navigator_bar_pages/profile_page/profile_app_bar.dart';
import 'package:takaful/view/navigator_bar_pages/profile_page/profile_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: SizedBox(
        child: ListView(
          children: [
            ProfileButton(
                screenHeigth: screenheigth,
                icon: Icons.shopping_bag_rounded,
                text: 'طلباتي'),
            ProfileButton(
                screenHeigth: screenheigth,
                icon: Icons.breakfast_dining_sharp,
                text: 'تبرعاتي'),
            ProfileButton(
                screenHeigth: screenheigth,
                icon: Icons.favorite,
                text: 'الإعلانات المحفوظة'),
            ProfileButton(
                screenHeigth: screenheigth,
                icon: Icons.settings,
                text: 'الاعدادات'),
            ProfileButton(
                screenHeigth: screenheigth,
                icon: Icons.manage_accounts,
                text: 'إدارة حسابي'),
            ProfileButton(
                screenHeigth: screenheigth,
                icon: Icons.share,
                text: 'مشاركة التطبيق'),
            ProfileButton(
                screenHeigth: screenheigth,
                icon: Icons.contact_support_rounded,
                text: 'تواصل معنا'),
            ProfileButton(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return const LoginPage();
                    },
                  ), (route) => false);
                },
                screenHeigth: screenheigth,
                icon: Icons.logout_rounded,
                text: 'تسجيل خروج'),
          ],
        ),
      ),
    );
  }
}
