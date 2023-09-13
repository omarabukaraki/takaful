import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  String? emailAddress;
  String? password;
  String? passwordTwo;
  String? name;
  String? mobileNo;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLodding = false;

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'الإسم',
                  onChanged: (userName) {
                    name = userName;
                  },
                ),
                CustomTextFiled(
                  hintText: 'البريد الإلكتروني',
                  onChanged: (email) {
                    emailAddress = email;
                  },
                ),
                CustomTextFiled(
                  hintText: 'رقم الهاتف',
                  onChanged: (mobileNumber) {
                    mobileNo = mobileNumber;
                  },
                ),
                CustomTextFiled(
                  typeText: true,
                  hintText: 'كلمة المرور',
                  onChanged: (userPassword) {
                    password = userPassword;
                  },
                ),
                CustomTextFiled(
                  typeText: true,
                  hintText: 'تأكيد كلمة المرور',
                  onChanged: (userPasswordTwo) {
                    passwordTwo = userPasswordTwo;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                    text: 'التسجيل',
                    color: kPrimary,
                    textColor: Colors.white,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (password == passwordTwo) {
                          setState(() {
                            isLodding = true;
                          });
                          try {
                            //start create user with email and password
                            await createUser();
                            //end create user with email and password

                            //start verification email
                            if (FirebaseAuth
                                    .instance.currentUser!.emailVerified ==
                                false) {
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'تم ارسال رسالة تحقق الى بريدك الالكتروني',
                                  textDirection: TextDirection.rtl,
                                ),
                                backgroundColor: Colors.green,
                              ));
                            }
                            //end verification email

                            //start handel email message
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'كلمة المرور ضعيفة للغاية ',
                                  textDirection: TextDirection.rtl,
                                ),
                                backgroundColor: Colors.red,
                              ));
                            } else if (e.code == 'email-already-in-use') {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  ' الحساب موجود بالفعل الرجاء تسجيل دخول',
                                  textDirection: TextDirection.rtl,
                                ),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                          //end handel email message

                          catch (e) {
                            // ignore: avoid_print
                            print(e.toString());
                          }
                          setState(() {
                            isLodding = false;
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'كلمة المرور غير متطابقة',
                              textDirection: TextDirection.rtl,
                            ),
                            backgroundColor: Colors.red,
                          ));
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
                            style: TextStyle(fontSize: 14, color: kPrimary)),
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
  }

  Future<void> createUser() async {
    // ignore: unused_local_variable
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
  }
}
