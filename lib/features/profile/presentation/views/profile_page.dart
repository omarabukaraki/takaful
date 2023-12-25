import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/account_verification/presentation/view/account_verification_page.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/auth/presentation/views/login_page.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import 'package:takaful/features/profile/presentation/views/manage_profile_page.dart';
import 'package:takaful/features/profile/presentation/views/widget/profile_app_bar.dart';
import 'package:takaful/features/profile/presentation/views/widget/profile_button.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../../my_donation/presentation/view/my_donation_page.dart';
import '../../../my_request/presentation/view/my_request_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = 'ProfilePage';
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<UserDetailsModel> user = [];
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsCubit>(context).getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenheigth = MediaQuery.of(context).size.height;
    return BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
      listener: (context, state) {
        if (state is GetUserDetailsLoading) {
          print('loading');
        } else if (state is GetUserDetailsSuccess) {
          user = state.user;
        } else if (state is GetUserDetailsFailure) {
          print('failure');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: ProfileAppBar(
            isVerified: user.isNotEmpty ? user[0].isVerified : false,
            text: user.isNotEmpty ? user[0].name : '',
            image: user.isNotEmpty
                ? user[0].image
                : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f&_gl=1*1p08skf*_ga*MTU3NDc4MjEzNi4xNjk0MDE3NjE4*_ga_CW55HF8NVT*MTY5NjA3NzM3Mi41Mi4xLjE2OTYwNzc4NzMuNTMuMC4w',
          ),
          body: SizedBox(
            child: ListView(
              children: [
                ProfileButton(
                  screenHeigth: screenheigth,
                  icon: Icons.manage_accounts,
                  text: 'إدارة حسابي',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ManageProfilePage();
                      },
                    ));
                  },
                ),
                ProfileButton(
                  screenHeigth: screenheigth,
                  icon: Icons.shopping_bag_rounded,
                  text: 'طلباتي',
                  onTap: () {
                    // BlocProvider.of<GetDonationRequestCubit>(context)
                    //     .donationList = [];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyRequestPage(),
                        ));
                  },
                ),
                ProfileButton(
                  screenHeigth: screenheigth,
                  icon: Icons.breakfast_dining_sharp,
                  text: 'تبرعاتي',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyDonationPage(),
                        ));
                  },
                ),
                //start save donation button
                // ProfileButton(
                //   screenHeigth: screenheigth,
                //   icon: Icons.favorite,
                //   text: 'الإعلانات المحفوظة',
                //   onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const SaveDonationPage(),
                //       )),
                // ),
                //end save donation button
                ProfileButton(
                  screenHeigth: screenheigth,
                  icon: Icons.verified,
                  text: 'توثيق الحساب',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AccountVerificationPage()));
                  },
                ),
                ProfileButton(
                    screenHeigth: screenheigth,
                    icon: Icons.settings,
                    text: 'الاعدادات'),
                ProfileButton(
                    screenHeigth: screenheigth,
                    icon: Icons.share,
                    text: 'مشاركة التطبيق'),
                ProfileButton(
                    onTap: () async {
                      // Uri uri = Uri.parse(
                      //     'mailto:takafulapplication@gmail.com?subject=Contact with Takaful Admin &body=Hi, Admin Takaful');
                      // if (!await launchUrl(uri)) {
                      //   print(uri);
                      // }
                    },
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
      },
    );
  }
}
