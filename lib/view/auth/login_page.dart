import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/component/create_account_button.dart';
import 'package:takaful/component/forget_password_button.dart';
import 'package:takaful/component/logo_takaful.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/cubit/login_cubit/login_cubit.dart';
import 'package:takaful/helper/show_snak_bar.dart';
import 'package:takaful/view/auth/register_page.dart';
import '../../component/custom_button.dart';
import '../../component/custom_textfiled.dart';
import '../navigator_bar_pages/navegator_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLodging = false;
  GlobalKey<FormState> formKey = GlobalKey();

  void clearText() {
    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLodging) {
          isLodging = true;
        } else if (state is LoginSuccess) {
          isLodging = false;
          clearText();
          // BlocProvider.of<PostCubit>(context).getPost();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const NavigatorBarPage();
            },
          ));
        } else if (state is LoginFailure) {
          isLodging = false;
          showSankBar(context, state.errMessage);
        } else if (state is ResetPasswordSuccess) {
          isLodging = false;
          showSankBar(context, ' لقد تم ارسال بريد لاعادة تعيين كلمة المرور',
              color: Colors.green);
        } else if (state is ResetPasswordFailure) {
          isLodging = false;
          showSankBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return BlurryModalProgressHUD(
          inAsyncCall: isLodging,
          progressIndicator:
              const SpinKitFadingCircle(color: AppColor.kPrimary, size: 90.0),
          dismissible: false,
          opacity: 0.4,
          child: Scaffold(
            body: SafeArea(
              child: Form(
                key: formKey,
                child: ListView(children: [
                  const SizedBox(height: 20),
                  // start logo takaful
                  const LogoTakaful(),
                  // end logo takaful
                  const Text('تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32,
                          color: AppColor.kPrimary,
                          fontWeight: FontWeight.w400)),
                  const Text(
                    'أضف التفاصيل الخاصة بك لتسجيل الدخول',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff7c7d7e),
                        fontWeight: FontWeight.w500,
                        height: 1.4285714285714286),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFiled(
                    icon: const Icon(Icons.email, color: AppColor.kPrimary),
                    hintText: 'البريد الإلكتروني',
                    onChanged: (emailAddress) {
                      email.text = emailAddress;
                    },
                  ),
                  CustomTextFiled(
                    icon: const Icon(Icons.lock, color: AppColor.kPrimary),
                    typeText: true,
                    hintText: 'كلمة المرور',
                    onChanged: (userPassword) {
                      password.text = userPassword;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      text: 'الدخول',
                      color: AppColor.kPrimary,
                      textColor: Colors.white,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).sginIn(
                              emailAddress: email.text,
                              password: password.text);
                        } else {}
                      }),
                  const SizedBox(height: 20),
                  ForgetPasswordButton(
                    onTap: () async {
                      BlocProvider.of<LoginCubit>(context)
                          .resetPassword(email: email.text);
                    },
                  ),
                  const SizedBox(height: 20),
                  CreateAccountButton(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const RegisterPage();
                        },
                      ));
                    },
                  ),
                  const SizedBox(height: 20)
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
