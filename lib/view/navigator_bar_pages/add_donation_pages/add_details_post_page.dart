import 'dart:io';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:takaful/component/counter_post.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/component/custom_button.dart';
import 'package:takaful/component/custom_textfiled.dart';
import 'package:takaful/constant.dart';
import 'package:takaful/cubit/post_cubit/post_cubit.dart';

class AddDetailsPost extends StatefulWidget {
  const AddDetailsPost({super.key});

  static String id = 'AddDetailsPost';

  @override
  State<AddDetailsPost> createState() => _AddDetailsPostState();
}

class _AddDetailsPostState extends State<AddDetailsPost> {
  int counter = 0;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController stateOfThePost = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isLoading = false;
  void clearText() {
    title.clear();
    location.clear();
    stateOfThePost.clear();
    description.clear();
  }

  File? file;
  final imagePicker = ImagePicker();
  var nameImage;
  var url;

  Future pickImageFromGallery() async {
    try {
      var pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      file = File(pickedImage.path);
      nameImage = basename(pickedImage.path);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future pickImageFromCamera() async {
    try {
      var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;
      file = File(pickedImage.path);
      nameImage = basename(pickedImage.path);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future uploadImage() async {
    try {
      var refStorage = FirebaseStorage.instance.ref('images/$nameImage');
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryAndItemService =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: CustomAppBar(
        textOne: categoryAndItemService[0],
        textTwo: 'أضف تفاصيل التبرع',
        button: true,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostLodging) {
            isLoading = true;
          } else if (state is PostAddSuccess) {
            isLoading = false;
            clearText();
            counter = 0;
          } else if (state is PostFailure) {
            isLoading = false;
          }
        },
        builder: (context, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: isLoading,
            progressIndicator:
                const SpinKitFadingCircle(color: kPrimary, size: 90.0),
            dismissible: false,
            opacity: 0.4,
            child: Form(
              key: formKey,
              child: ListView(children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(right: 29),
                  child: Text(
                    'أضف صورة للتبرع',
                    style: TextStyle(fontSize: 17, color: kFont),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await pickImageFromGallery();
                              await uploadImage();
                              // setState(() {});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              height: 164,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kPrimary),
                              child: const Icon(
                                Icons.image,
                                size: 60,
                                color: Colors.white,
                              ),
                            )),
                        GestureDetector(
                            onTap: () async {
                              await pickImageFromCamera();
                              await uploadImage();
                              // setState(() {});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              height: 164,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kPrimary),
                              child: const Icon(
                                Icons.camera_enhance,
                                size: 60,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    )),
                const SizedBox(height: 10),
                CustomTextFiled(
                  controller: title,
                  onChanged: (postTitle) {
                    title.text = postTitle;
                  },
                  hintText: 'العنوان',
                  icon: const Icon(Icons.title_rounded),
                ),
                CustomTextFiled(
                  controller: location,
                  onChanged: (postLocation) {
                    location.text = postLocation;
                  },
                  hintText: 'الموقع',
                  icon: const Icon(Icons.location_on),
                ),
                CustomTextFiled(
                  controller: stateOfThePost,
                  onChanged: (p0) {
                    stateOfThePost.text = p0;
                  },
                  hintText: 'الحالة',
                  icon: const Icon(Icons.fiber_new_rounded),
                ),
                categoryAndItemService[0].length <= 5
                    ? CounterPost(
                        counter: counter,
                        onTapAdd: () {
                          setState(() {
                            if (counter < 500) {
                              counter++;
                            } else {
                              counter = 500;
                            }
                          });
                        },
                        onTapRemove: () {
                          setState(() {
                            if (counter > 0) {
                              counter--;
                            } else {
                              counter = 0;
                            }
                          });
                        },
                      )
                    : const SizedBox(),
                CustomTextFiled(
                  controller: description,
                  onChanged: (postDescription) {
                    description.text = postDescription;
                  },
                  hintText: 'الوصف',
                  icon: const Icon(Icons.description),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  circular: 20,
                  text: 'نشر التبرع',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<PostCubit>(context).addPost(
                        postState: true,
                        title: title.text,
                        image: url,
                        category: categoryAndItemService[1],
                        itemOrService: categoryAndItemService[0],
                        description: description.text,
                        location: location.text,
                        state: stateOfThePost.text,
                        count: counter,
                      );
                    }
                  },
                  textColor: Colors.white,
                  color: kPrimary,
                ),
                const SizedBox(
                  height: 20,
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
