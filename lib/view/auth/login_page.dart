import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  String? emailAddress;
  String? password;
  bool isLodding = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLodding,
      progressIndicator: const SpinKitFadingCircle(color: kPrimary, size: 90.0),
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
                onChanged: (p0) {
                  emailAddress = p0;
                },
              ),
              CustomTextFiled(
                icon: const Icon(Icons.lock, color: kPrimary),
                typeText: true,
                hintText: 'كلمة المرور',
                onChanged: (p0) {
                  password = p0;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: 'الدخول',
                  color: kPrimary,
                  textColor: Colors.white,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLodding = true;
                      });
                      try {
                        //start sginIn user with email and password
                        await sginIn();
                        //end sginIn user with email and password

                        //!start handel email verified
                        if (FirebaseAuth.instance.currentUser!.emailVerified ==
                            true) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const NavigatorBarPage();
                            },
                          ));
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'الرجاء تأكيد الحساب',
                              textDirection: TextDirection.rtl,
                            ),
                            backgroundColor: Colors.green,
                          ));
                        }
                        //!end handel email verified

                        //start handel email and password messages
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'لم يتم العثور على مستخدم لهذا البريد الإلكتروني.',
                              textDirection: TextDirection.rtl,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        } else if (e.code == 'wrong-password') {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              ' كلمة المرور خاطئة',
                              textDirection: TextDirection.rtl,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                      //start handel email and password messages

                      setState(() {
                        isLodding = false;
                      });
                    } else {}
                  }),
              const SizedBox(height: 20),
              ForgetPasswordButton(),
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
  }

  Future<void> sginIn() async {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress!, password: password!);
  }
}

class LogoTakaful extends StatelessWidget {
  const LogoTakaful({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        Text('تكافل', style: TextStyle(fontSize: 51, color: kPrimary)),
        Text('Takaful',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: kPrimary)),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAve(image: 'assets/image/foodlogin.png'),
              CircleAve(
                image: 'assets/image/clotherss.png',
                color: Colors.white,
              ),
              CircleAve(image: 'assets/image/sofa.png'),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Text("انشاء حساب",
              style: TextStyle(fontSize: 14, color: kPrimary)),
        ),
        const Text('ليس لديك حساب؟',
            style: TextStyle(color: Color(0xff7c7d7e))),
      ],
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text(
        'نسيت كلمة السر؟',
        style: TextStyle(
            fontSize: 14,
            color: Color(0xff7c7d7e),
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CircleAve extends StatelessWidget {
  const CircleAve({
    this.color,
    required this.image,
    super.key,
  });
  final String image;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kPrimary,
      radius: 27,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: color ?? kPrimary,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
