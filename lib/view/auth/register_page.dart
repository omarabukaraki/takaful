import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/cubit/register_cubit/register_cubit.dart';
import 'package:takaful/helper/show_snak_bar.dart';
import 'package:takaful/view/auth/login_page.dart';
import '../../../component/custom_button.dart';
import '../../../component/custom_textfiled.dart';
import '../../constant.dart';

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
  TextEditingController mobileNo = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLodding = false;

  void clearText() {
    email.clear();
    password.clear();
    passwordTwo.clear();
    name.clear();
    mobileNo.clear();
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
              color: Colors.green);
        } else if (state is RegisterFailure) {
          isLodding = false;
          showSankBar(context, state.errMassage);
        }
      },
      builder: (context, state) {
        return BlurryModalProgressHUD(
          inAsyncCall: isLodding,
          progressIndicator: const SpinKitFadingCircle(
            color: kPrimary,
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0.4,
          child: Scaffold(
            backgroundColor: Colors.white,
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
                            'إنشاء حساب مستخدم',
                            style: TextStyle(fontSize: 30, color: kPrimary),
                          ),
                          Text('أضف التفاصيل الخاصة بك للتسجيل',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    CustomTextFiled(
                      controller: name,
                      hintText: 'الإسم',
                      onChanged: (userName) {
                        name.text = userName;
                      },
                    ),
                    CustomTextFiled(
                      controller: email,
                      hintText: 'البريد الإلكتروني',
                      onChanged: (emailAddress) {
                        email.text = emailAddress;
                      },
                    ),
                    CustomTextFiled(
                      controller: mobileNo,
                      hintText: 'رقم الهاتف',
                      onChanged: (mobileNumber) {
                        mobileNo.text = mobileNumber;
                      },
                    ),
                    CustomTextFiled(
                      controller: password,
                      typeText: true,
                      hintText: 'كلمة المرور',
                      onChanged: (userPassword) {
                        password.text = userPassword;
                      },
                    ),
                    CustomTextFiled(
                      controller: passwordTwo,
                      typeText: true,
                      hintText: 'تأكيد كلمة المرور',
                      onChanged: (userPasswordTwo) {
                        passwordTwo.text = userPasswordTwo;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        text: 'التسجيل',
                        color: kPrimary,
                        textColor: Colors.white,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (password.text == passwordTwo.text) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .createUser(
                                      email: email.text,
                                      password: password.text);
                            } else {
                              showSankBar(context, 'كلمة المرور غير متطابقة');
                            }
                          } else {}
                        }),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const LoginPage();
                                },
                              ));
                            },
                            child: const Text("تسجيل الدخول",
                                style:
                                    TextStyle(fontSize: 14, color: kPrimary)),
                          ),
                          const Text(' هل لديك حساب؟',
                              style: TextStyle(color: Color(0xff7c7d7e))),
                        ],
                      ),
                    ),
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
