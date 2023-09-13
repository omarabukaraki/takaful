import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/component/create_account_button.dart';
import 'package:takaful/component/forget_password_button.dart';
import 'package:takaful/component/logo_takaful.dart';
import 'package:takaful/cubit/login_cubit/login_cubit.dart';
import 'package:takaful/helper/show_snak_bar.dart';
import 'package:takaful/view/auth/register.dart';
import '../../component/custom_button.dart';
import '../../component/custom_textfiled.dart';
import '../../constant.dart';
import '../navigator_bar_pages/navegator_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool inAsyncCall = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLodging) {
          inAsyncCall = true;
        } else if (state is LoginSuccess) {
          inAsyncCall = false;
          // BlocProvider.of<PostCubit>(context).getPost();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const NavigatorBarPage();
            },
          ));
        } else if (state is LoginFailure) {
          inAsyncCall = false;
          showSankBar(context, state.errMessage);
        } else if (state is ResetPasswordSuccess) {
          inAsyncCall = false;
          showSankBar(context, ' لقد تم ارسال بريد لاعادة تعيين كلمة المرور',
              color: Colors.green);
        } else if (state is ResetPasswordFailure) {
          inAsyncCall = false;
          showSankBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return BlurryModalProgressHUD(
          inAsyncCall: inAsyncCall,
          progressIndicator:
              const SpinKitFadingCircle(color: kPrimary, size: 90.0),
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
                          color: kPrimary,
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
                    icon: const Icon(Icons.email, color: kPrimary),
                    hintText: 'البريد الإلكتروني',
                    onChanged: (emailAddress) {
                      email = emailAddress;
                    },
                  ),
                  CustomTextFiled(
                    icon: const Icon(Icons.lock, color: kPrimary),
                    typeText: true,
                    hintText: 'كلمة المرور',
                    onChanged: (userPassword) {
                      password = userPassword;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      text: 'الدخول',
                      color: kPrimary,
                      textColor: Colors.white,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).sginIn(
                              emailAddress: email!, password: password!);
                        } else {}
                      }),
                  const SizedBox(height: 20),
                  ForgetPasswordButton(
                    onTap: () async {
                      BlocProvider.of<LoginCubit>(context)
                          .resetPassword(email: email!);
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
