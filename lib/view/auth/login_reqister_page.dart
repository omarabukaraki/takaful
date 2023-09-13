import 'package:flutter/material.dart';
import 'package:takaful/view/auth/register_page.dart';

import '../../component/circlr_logo.dart';
import '../../component/custom_button.dart';

import 'login_page.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Stack(
              alignment: const Alignment(0, 2.4),
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: Color(0xff3A44A0),
                  ),
                  child: Image.asset(
                    'assets/image/Background objects.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const CircleLogo(),
              ],
            ),
            const SizedBox(
              width: double.infinity,
              height: 120,
              // child: Image.asset(
              //   'assets/image/Mask Group 2193.png',
              //   fit: BoxFit.cover,
              // ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ));
              },
              text: 'تسجيل الدخول',
              color: const Color(0xff3A44A0),
              textColor: Colors.white,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const RegisterPage();
                  },
                ));
              },
              text: 'إنشاء حساب',
              color: Colors.white,
              textColor: const Color(0xff3A44A0),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
