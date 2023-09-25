// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/component/custom_button.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/cubit/add_images_cubit/add_images_cubit.dart';
import 'package:takaful/helper/show_snak_bar.dart';

class AddImages extends StatefulWidget {
  const AddImages({super.key});

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  final imagePicker = ImagePicker();
  List<File> image = [];
  List<String> url = [];
  bool formGallery = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          button: false,
          textOne: AppString.textAddImageToDonation,
          textTwo: ''),
      body: BlocConsumer<AddImagesCubit, AddImagesState>(
        listener: (context, state) {
          if (state is AddImagesSuccess) {
            image = state.image;
          } else if (state is UploadImagesSuccess) {
            url = state.url;
          } else if (state is AddImagesFailure) {
            showSankBar(context, state.errMessage);
          } else if (state is UploadImagesFailure) {
            showSankBar(context, state.errMessage);
          }
        },
        builder: (context, state) {
          return Column(children: [
            image.isEmpty
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(':' 'حدد الطريقة ',
                                textAlign: TextAlign.center),
                            actions: [
                              CustomButtonToAlertDialog(
                                titleButton: 'من المعرض',
                                onTap: () {
                                  formGallery = true;
                                  BlocProvider.of<AddImagesCubit>(context)
                                      .pickImageFromGallery(index: 0);
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButtonToAlertDialog(
                                titleButton: 'بأستخدام الكاميرا',
                                onTap: () async {
                                  formGallery = false;
                                  BlocProvider.of<AddImagesCubit>(context)
                                      .pickImageFromCamera(index: 0);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: AddImagesComponent(),
                    ))
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ImageDisplayed(image: image[0]),
                  ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return image.length <= index + 1
                        ? GestureDetector(
                            onTap: () async {
                              if (image.isEmpty) {
                                showSankBar(
                                    context, 'please select cover of post');
                              } else {
                                if (formGallery == true) {
                                  BlocProvider.of<AddImagesCubit>(context)
                                      .pickImageFromGallery(index: index + 1);
                                } else {
                                  BlocProvider.of<AddImagesCubit>(context)
                                      .pickImageFromCamera(index: index + 1);
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: AddImagesComponent(
                                textOne: 'اضافة صورة',
                                isOneText: true,
                              ),
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(5),
                            child: ImageDisplayed(image: image[index + 1]),
                          );
                  },
                ),
              ),
            ),
            url.length == image.length
                ? CustomButton(
                    text: 'اضافة',
                    color: AppColor.kPrimary,
                    textColor: AppColor.kWhite,
                    onTap: () {
                      if (image.isNotEmpty) {
                        Navigator.pop(context);
                      } else {
                        showSankBar(context, 'الرجاء اختيار صورة');
                      }
                    })
                : const CircularProgressIndicator(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            )
          ]);
        },
      ),
    );
  }
}

class ImageDisplayed extends StatelessWidget {
  const ImageDisplayed({
    super.key,
    required this.image,
  });

  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 164,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 4, offset: Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: FileImage(image), fit: BoxFit.cover)),
    );
  }
}

class AddImagesComponent extends StatelessWidget {
  const AddImagesComponent(
      {super.key, this.textOne, this.textTwo, this.isOneText});
  final String? textOne;
  final String? textTwo;
  final bool? isOneText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 164,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: AppColor.kGrey, blurRadius: 5, offset: Offset(0, 2))
      ], borderRadius: BorderRadius.circular(20), color: AppColor.kPrimary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            textOne ?? 'الصورة الرئيسية',
            style: const TextStyle(color: AppColor.kWhite, fontSize: 14),
          ),
          isOneText != true
              ? Text(textTwo ?? '(مطلوب)',
                  style: const TextStyle(color: AppColor.kWhite, fontSize: 12))
              : const SizedBox()
        ],
      ),
    );
  }
}

class CustomButtonToAlertDialog extends StatelessWidget {
  const CustomButtonToAlertDialog({
    Key? key,
    this.titleButton,
    this.onTap,
  }) : super(key: key);
  final String? titleButton;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: AppColor.kPrimary),
        child: Center(
            child: Text(titleButton ?? 'المعرض',
                style: const TextStyle(color: AppColor.kWhite))),
      ),
    );
  }
}
  // onTap: () {
  //                   showDialog(
  //                     context: context,
  //                     builder: (context) {
  //                       return AlertDialog(
  //                         title: const Text(':' 'حدد الطريقة ',
  //                             textAlign: TextAlign.center),
  //                         actions: [
  //                           CustomButtonToAlertDialog(
  //                             titleButton: 'من المعرض',
  //                             onTap: () async {
  //                               formGallery = true;
  //                               await pickImageFromGallery(index: 0);
  //                               // ignore: use_build_context_synchronously
  //                               Navigator.pop(context);
  //                               setState(() {});
  //                               await uploadImage(index: 0);
  //                             },
  //                           ),
  //                           const SizedBox(
  //                             height: 10,
  //                           ),
  //                           CustomButtonToAlertDialog(
  //                             titleButton: 'بأستخدام الكاميرا',
  //                             onTap: () async {
  //                               formGallery = false;
  //                               await pickImageFromCamera(index: 0);
  //                               // ignore: use_build_context_synchronously
  //                               Navigator.pop(context);
  //                               setState(() {});

  //                               await uploadImage(index: 0);
  //                             },
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   );
  //                 },