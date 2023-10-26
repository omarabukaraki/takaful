import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/add_donation/presentation/cubit/add_images_cubit/add_images_cubit.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:takaful/features/profile/presentation/cubit/delete_account/delete_account_cubit.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/add_image_profile_button.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/change_password_button.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/display_email.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/edit_text_field.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/manage_profile_button.dart';

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
                        //start pick image and upload
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
                              Navigator.pop(context);
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
                        //end pick image and upload
                        const SizedBox(height: 10),
                        //start name text field
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
                        //end name text field

                        //start mobile number text field
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
                        //end mobile number text field

                        //start display email
                        DisplayEmail(user: user),
                        //end display email

                        //start change password button
                        //
                        ChangePasswordButton(
                          onTap: () {
                            BlocProvider.of<LoginCubit>(context)
                                .resetPassword(email: user[0].email);
                            showSankBar(context,
                                'لقد تم اسال بريد لاعادة تعيين كلمة المرور',
                                color: AppColor.kGreen);
                          },
                        ),
                        //
                        //end change password button

                        //start delete account button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Row(
                            children: [
                              ManageProfileButton(
                                onTap: () async {
                                  BlocProvider.of<DeleteAccountCubit>(context)
                                      .confirmationDialog(context,
                                          docId: docId!);
                                },
                              ),
                              //start save edit button
                              //
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
                              //
                              //end save edit button
                            ],
                          ),
                        )
                        //end delete account button
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
