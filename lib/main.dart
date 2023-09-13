// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/constant.dart';
import 'package:takaful/cubit/login_cubit/login_cubit.dart';
import 'package:takaful/cubit/post_cubit/post_cubit.dart';
import 'package:takaful/cubit/register_cubit/register_cubit.dart';
import 'package:takaful/view/auth/splash_screen.dart';
import 'package:takaful/view/items_page/items_type_page.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_details_post_page.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_item_donation.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_service_donation.dart';
import 'package:takaful/view/navigator_bar_pages/navegator_page.dart';
import 'package:takaful/view/notifcation_page.dart';
import 'package:takaful/view/posts_page/posts_page.dart';
import 'package:takaful/view/servives_pages/service_type_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => PostCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          AddServiceDonation.id: (context) => AddServiceDonation(),
          AddItemDonation.id: (context) => AddItemDonation(),
          AddDetailsPost.id: (context) => AddDetailsPost(),
          ItemTypePage.id: (context) => ItemTypePage(),
          ServiceTypePage.id: (context) => ServiceTypePage(),
          NotificationPage.id: (context) => NotificationPage(),
          PostPage.id: (context) => PostPage(),
        },
        title: 'takaful',
        theme: ThemeData(
          fontFamily: 'ElMessiri',
          colorScheme: ColorScheme.fromSeed(
              seedColor: kPrimary, background: Colors.white),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? NavigatorBarPage()
            : SplashScreen(),
      ),
    );
  }
}
