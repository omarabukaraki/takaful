// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/add_donation/presentation/cubit/add_images_cubit/add_images_cubit.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/add_image_profile_button.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/change_password_button.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/manage_profile_button.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/text_fiald.dart';
import 'package:takaful/features/splash/presentation/views/splash_view.dart';

class ManageProfilePage extends StatefulWidget {
  const ManageProfilePage({super.key});

  @override
  State<ManageProfilePage> createState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends State<ManageProfilePage> {
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsCubit>(context).getUserDetails();
    super.initState();
  }

  String? docId;
  bool readOnly = true;
  bool isLoading = false;
  bool inAsyncCall = false;
  List<String> url = [];
  List<UserDetailsModel> user = [];
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        button: true,
        textOne: 'ادارة حسابي',
        textTwo: '',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
        listener: (context, state) {
          if (state is GetUserDetailsSuccess) {
            user = state.user;
            name.text = state.user[0].name;
            mobileNumber.text = state.user[0].mobileNumber;
            docId = BlocProvider.of<GetUserDetailsCubit>(context).docId;
          }
        },
        builder: (context, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: inAsyncCall,
            child: SingleChildScrollView(
              child: user.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        BlocConsumer<AddImagesCubit, AddImagesState>(
                          listener: (context, state) {
                            if (state is UploadImagesLoading) {
                              isLoading = true;
                            } else if (state is UploadImagesSuccess) {
                              url =
                                  BlocProvider.of<AddImagesCubit>(context).url;
                              users.doc(docId).update({'image': url[0]});
                              isLoading = false;
                              BlocProvider.of<AddImagesCubit>(context).image =
                                  [];
                              BlocProvider.of<AddImagesCubit>(context).url = [];
                              BlocProvider.of<AddImagesCubit>(context)
                                  .nameImage = [];
                              url = [];
                            }
                          },
                          builder: (context, state) {
                            return isLoading
                                ? const CircleAvatar(
                                    backgroundColor: AppColor.kPrimary,
                                    radius: 60,
                                    child: CircularProgressIndicator(
                                        color: AppColor.kWhite),
                                  )
                                : AddImageProfileButton(
                                    onTap: () async {
                                      await BlocProvider.of<AddImagesCubit>(
                                              context)
                                          .pickImageFromGallery(index: 0);
                                    },
                                    user: user);
                          },
                        ),
                        const SizedBox(height: 10),
                        EditTextField(
                          labelText: 'الاسم',
                          readOnly: readOnly,
                          hintText: user.isNotEmpty ? user[0].name : '',
                          controller: name,
                          onChanged: (p0) {
                            name.text = p0;
                          },
                          onTap: () {
                            setState(() {
                              readOnly = false;
                            });
                          },
                        ),
                        EditTextField(
                          onTap: () {
                            setState(() {
                              readOnly = false;
                            });
                          },
                          labelText: 'رقم الهاتف',
                          readOnly: readOnly,
                          hintText: user.isNotEmpty ? user[0].mobileNumber : '',
                          controller: mobileNumber,
                          onChanged: (mobileNum) {
                            mobileNumber.text = mobileNum;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 45),
                                child: Text('البريد الالكتروني',
                                    style: TextStyle(color: AppColor.kPrimary)),
                              ),
                              ManageProfileTextField(
                                  readOnly: true,
                                  hintText:
                                      user.isNotEmpty ? user[0].email : ''),
                            ],
                          ),
                        ),
                        ChangePasswordButton(
                          onTap: () {
                            BlocProvider.of<LoginCubit>(context)
                                .resetPassword(email: user[0].email);
                            showSankBar(context,
                                'لقد تم اسال بريد لاعادة تعيين كلمة المرور',
                                color: AppColor.kGreen);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Row(
                            children: [
                              ManageProfileButton(
                                onTap: () async {
                                  try {
                                    await FirebaseAuth.instance.currentUser!
                                        .delete();
                                    await FirebaseAuth.instance.signOut();
                                    await users.doc(docId).delete();
                                  } catch (e) {
                                    print(e);
                                  }
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SplashView(),
                                      ));
                                },
                              ),
                              ManageProfileButton(
                                  onTap: () async {
                                    setState(() {
                                      inAsyncCall = true;
                                    });
                                    await users.doc(docId).update({
                                      'name': name.text,
                                      'mobileNumber': mobileNumber.text
                                    });
                                    setState(() {
                                      readOnly = true;
                                      inAsyncCall = false;
                                    });
                                  },
                                  color: AppColor.kPrimary,
                                  text: 'حفظ التعديل'),
                            ],
                          ),
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

//
//

//
//

//
//

//
//

//
//

//
//

//
//

//
//

//
//

//
//

//
//

//
//

class EditTextField extends StatelessWidget {
  const EditTextField(
      {super.key,
      required this.readOnly,
      this.onTap,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.controller});

  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Text(
              labelText ?? 'label',
              style: const TextStyle(color: AppColor.kPrimary),
            ),
          ),
          Stack(alignment: const Alignment(1, -2), children: [
            ManageProfileTextField(
              controller: controller,
              onChanged: onChanged,
              hintText: hintText ?? 'الاسم',
              readOnly: readOnly,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.kPrimary),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    )),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}


  // print(
  //                         BlocProvider.of<GetUserDetailsCubit>(context).docId);
  //                     users
  //                         .doc(BlocProvider.of<GetUserDetailsCubit>(context)
  //                             .docId)
  //                         .update({'name': 'omar'});
  //                     setState(() {
  //                       readOnly = false;
  //                     });