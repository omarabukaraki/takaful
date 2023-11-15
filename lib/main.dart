import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/bloc_observer.dart';
import 'package:takaful/core/routes/app_routes.dart';
import 'package:takaful/features/donation_request/presentation/cubit/get_donation_request/get_donation_request_cubit.dart';
import 'package:takaful/features/profile/presentation/views/my_donation/cubit/cubit/edit_and_delete_donation_cubit.dart';
import 'core/utils/app_colors.dart';
import 'features/add_donation/presentation/cubit/add_donation_cubit/add_donation_cubit.dart';
import 'features/add_donation/presentation/cubit/add_images_cubit/add_images_cubit.dart';
import 'features/add_donation/presentation/cubit/add_location/add_location_cubit.dart';
import 'features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'features/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'features/donation_request/presentation/cubit/request_donaiton/request_donation_cubit.dart';
import 'features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'features/home/presentation/views/navegator_page.dart';
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
          create: (context) => AddDonationCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => AddImagesCubit(),
        ),
        BlocProvider(
          create: (context) => GetDonationCubit(),
        ),
        BlocProvider(
          create: (context) => AddLocationCubit(),
        ),
        BlocProvider(
          create: (context) => GetUserDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteAccountCubit(),
        ),
        BlocProvider(
          create: (context) => RequestDonationCubit(),
        ),
        BlocProvider(
          create: (context) => GetDonationRequestCubit(),
        ),
        BlocProvider(
          create: (context) => EditAndDeleteDonationCubit(),
        ),
        // BlocProvider(
        //   create: (context) => SaveDonationCubit(),
        // )
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
