import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/constant.dart';
import 'package:takaful/view/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'تكافل',
              style: TextStyle(
                  fontSize: 51,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'ElMessiri'),
            ),
            const Text(
              'Takaful',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'ElMessiri',
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 75.0, vertical: 5),
              child: Image.asset('assets/image/threeinone.png'),
            ),
            const SpinKitThreeInOut(color: Colors.white, size: 50.0),
          ],
        ));
  }
}
