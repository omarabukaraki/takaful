import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/bloc_observer.dart';
import 'package:takaful/core/routes/app_routes.dart';
import 'package:takaful/features/account_verification/presentation/cubit/account_verification/account_verification_cubit.dart';
import 'package:takaful/features/donation_request/presentation/cubit/accept_request/accept_request_cubit.dart';
import 'package:takaful/features/home/presentation/cubit/cubit/get_ads_cubit.dart';
import 'package:takaful/features/notification/presentation/cubit/get_user_and_notification/get_user_and_notification_cubit.dart';
import 'package:takaful/features/notification/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:takaful/notification_services.dart';
import 'core/utils/app_colors.dart';
import 'features/account_verification/presentation/cubit/add_image_to_verification_account_cubit/add_image_to_verification_account_cubit.dart';
import 'features/add_donation/presentation/cubit/add_donation_cubit/add_donation_cubit.dart';
import 'features/add_donation/presentation/cubit/add_images_cubit/add_images_cubit.dart';
import 'features/add_donation/presentation/cubit/add_location/add_location_cubit.dart';
import 'features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'features/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'features/donation_request/presentation/cubit/get_request/get_request_cubit.dart';
import 'features/donation_request/presentation/cubit/send_notification/send_notification_cubit.dart';
import 'features/get_category/presentation/cubit/cubit/get_category_cubit.dart';
import 'features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'features/get_donation/presentation/cubit/rating_user/rating_user_cubit.dart';
import 'features/get_donation/presentation/cubit/request_donation/request_donation_cubit.dart';
import 'features/home/presentation/views/navegator_page.dart';
import 'features/my_donation/presentation/cubit/cubit/edit_and_delete_donation_cubit.dart';
import 'features/profile/presentation/cubit/delete_account/delete_account_cubit.dart';
import 'features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocobserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await notificationInitialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AddDonationCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => AddImagesCubit()),
        BlocProvider(create: (context) => GetDonationCubit()),
        BlocProvider(create: (context) => AddLocationCubit()),
        BlocProvider(create: (context) => GetUserDetailsCubit()),
        BlocProvider(create: (context) => DeleteAccountCubit()),
        BlocProvider(create: (context) => RequestDonationCubit()),
        BlocProvider(create: (context) => EditAndDeleteDonationCubit()),
        BlocProvider(create: (context) => GetRequestCubit()),
        BlocProvider(create: (context) => AcceptRequestCubit()),
        BlocProvider(create: (context) => SendNotificationCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => GetCategoryCubit()),
        BlocProvider(create: (context) => AccountVerificationCubit()),
        BlocProvider(create: (context) => AddImageToVerificationAccountCubit()),
        BlocProvider(create: (context) => GetAdsCubit()),
        BlocProvider(create: (context) => GetUserAndNotificationCubit()),
        BlocProvider(create: (context) => RatingUserCubit()),
      ],
      child: MaterialApp(
        title: 'takaful',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'ElMessiri',
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.kPrimary, background: Colors.white),
          useMaterial3: true,
        ),
        routes: AppRoutes.route,
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? const NavigatorBarPage()
            : const SplashView(),
      ),
    );
  }
}
