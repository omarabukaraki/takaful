import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/auth/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:takaful/features/auth/presentation/views/widget/create_register_account_button.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';
import 'package:takaful/features/auth/presentation/views/login_page.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfiled.dart';
import 'widget/custom_text_filed_for_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordTwo = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLodding = false;

  void clearText() {
    email.clear();
    password.clear();
    passwordTwo.clear();
    name.clear();
    mobileNumber.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLodging) {
          isLodding = true;
        } else if (state is RegisterSuccess) {
          isLodding = false;
          clearText();
          showSankBar(context, 'تم ارسال رسالة تحقق الى بريدك الالكتروني',
              color: AppColor.kGreen);
        } else if (state is RegisterFailure) {
          isLodding = false;
          showSankBar(context, state.errMassage);
        }
      },
      builder: (context, state) {
        return BlurryModalProgressHUD(
          inAsyncCall: isLodding,
          progressIndicator: const SpinKitFadingCircle(
            color: AppColor.kPrimary,
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0.4,
          child: Scaffold(
            backgroundColor: AppColor.kWhite,
            body: SafeArea(
              child: Center(
                child: Form(
                  key: formKey,
                  child: ListView(children: [
                    const SizedBox(height: 50),
                    const SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Text(
                            AppString.textCreateUserAccountArabic,
                            style: TextStyle(
                                fontSize: 30, color: AppColor.kPrimary),
                          ),
                          Text(AppString.textAddDetailsToRegister,
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    CustomTextFiled(
                      controller: name,
                      hintText: AppString.textNameArabic,
                      onChanged: (userName) {
                        name.text = userName;
                      },
                    ),
                    CustomTextFiledForAuth(
                      controller: email,
                      hintText: AppString.textEmailArabic,
                      onChanged: (emailAddress) {
                        email.text = emailAddress;
                      },
                    ),
                    CustomTextFiledForPhone(
                      controller: mobileNumber,
                      hintText: AppString.textMobileNumberArabic,
                      onChanged: (mobileNum) {
                        mobileNumber.text = mobileNum;
                      },
                    ),
                    CustomTextFiled(
                      controller: password,
                      typeText: true,
                      hintText: AppString.textPasswordArabic,
                      onChanged: (userPassword) {
                        password.text = userPassword;
                      },
                    ),
                    CustomTextFiled(
                      controller: passwordTwo,
                      typeText: true,
                      hintText: AppString.textConfirmPasswordArabic,
                      onChanged: (userPasswordTwo) {
                        passwordTwo.text = userPasswordTwo;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        text: AppString.textRegisterArabic,
                        color: AppColor.kPrimary,
                        textColor: Colors.white,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (password.text == passwordTwo.text) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .createUser(
                                      name: name.text,
                                      mobileNumber: mobileNumber.text,
                                      email: email.text,
                                      password: password.text);
                            } else {
                              showSankBar(
                                  context, AppString.textPasswordMismatch);
                            }
                          } else {}
                        }),
                    const SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CreateAccountButton(
                          textOne: AppString.textLoginArabic,
                          textTwo: AppString.textDoYouHaveAnAccount,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ));
                          },
                        )),
                    const SizedBox(height: 20)
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
