import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/core/utils/app_assets.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/auth/presentation/views/login_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static String id = 'SplashScreen';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
        backgroundColor: AppColor.kPrimary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              AppString.textTakafulArabicName,
              style: TextStyle(
                  fontSize: 51,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kWhite),
            ),
            const Text(
              AppString.textTakafulEnglishName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.kWhite,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 75.0, vertical: 5),
              child: Image.asset(AppAssets.assetsImageThreeInOne),
            ),
            const SpinKitThreeInOut(color: AppColor.kWhite, size: 50.0),
          ],
        ));
  }
}
