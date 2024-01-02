// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'widget/add_image_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widget/account_verification_text_field.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/widgets/custom_button.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import 'package:takaful/features/account_verification/presentation/cubit/account_verification/account_verification_cubit.dart';

class AccountVerificationPage extends StatefulWidget {
  const AccountVerificationPage({super.key});

  @override
  State<AccountVerificationPage> createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState extends State<AccountVerificationPage> {
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsCubit>(context).userDonationInformation(
        email: FirebaseAuth.instance.currentUser!.email!);
    super.initState();
  }

  UserDetailsModel? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          button: true,
          textOne: 'توثيق الحساب',
          textTwo: '',
          onTap: () {
            Navigator.pop(context);
            url = null;
          }),
      body: BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
        listener: (context, state) {
          if (state is GetUserDetailsSuccessForDonation) {
            user = state.user;
          }
        },
        builder: (context, state) {
          return ListView(children: [
            const AddImageComponent(),
            const SizedBox(height: 10),
            AccountVerificationTextField(
              hintText: user != null ? user!.name : '',
            ),
            const SizedBox(height: 10),
            AccountVerificationTextField(
                label: 'رقم الهاتف',
                hintText: user != null ? user!.mobileNumber : ''),
            const SizedBox(height: 10),
            AccountVerificationTextField(
                label: 'البريد الالكتروني',
                hintText: user != null ? user!.email : ''),
            const SizedBox(height: 20),
            user != null
                ? user!.isVerified != true
                    ? CustomButton(
                        color: AppColor.kPrimary,
                        textColor: AppColor.kWhite,
                        text: 'إرسال طلب',
                        onTap: () async {
                          if (url != null) {
                            await BlocProvider.of<AccountVerificationCubit>(
                                    context)
                                .sendVerificationRequest(
                                    image: url!,
                                    userEmail: FirebaseAuth
                                        .instance.currentUser!.email!);
                            url = null;
                            showSankBar(context, 'تم ارسال الطلب بنجاح',
                                color: AppColor.kGreen);
                            Navigator.pop(context);
                          } else {
                            showSankBar(context, 'الرجاء إضافة صورة',
                                color: AppColor.kRed);
                          }
                        },
                      )
                    : CustomButton(
                        color: AppColor.kPrimary,
                        textColor: AppColor.kWhite,
                        text: 'لقد تم توثيقك بالفعل',
                        onTap: () async {
                          showSankBar(context, 'لقد تم توثيقك بالفعل',
                              color: AppColor.kGreen);
                        },
                      )
                : const CircularProgressIndicator(),
          ]);
        },
      ),
    );
  }
}
