// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/core/widgets/custom_button.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/add_donation/presentation/cubit/add_images_cubit/add_images_cubit.dart';
import 'package:takaful/features/add_donation/presentation/views/widgets/add_images_component.dart';
import 'package:takaful/features/add_donation/presentation/views/widgets/alert_dialog_button.dart';
import 'package:takaful/features/add_donation/presentation/views/widgets/image_displayed.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';

class AddImagesPage extends StatefulWidget {
  const AddImagesPage({super.key});

  @override
  State<AddImagesPage> createState() => _AddImagesPageState();
}

class _AddImagesPageState extends State<AddImagesPage> {
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
                      //start show dialog and display to choose
                      //
                      //
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(':' 'حدد الطريقة ',
                                textAlign: TextAlign.center),
                            actions: [
                              AlertDialogButton(
                                titleButton: 'من المعرض',
                                onTap: () {
                                  formGallery = true;
                                  BlocProvider.of<AddImagesCubit>(context)
                                      .pickImageFromGallery(index: 0);
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(height: 10),
                              AlertDialogButton(
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
                      //
                      //
                      //end show dialog and display to choose
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
            // start display grid view to pick images
            //
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
                                iconSize: 30,
                                fontSize: 12,
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
            //
            //end display grid view to pick images

            //start custom button
            //
            url.length == image.length
                ? CustomButton(
                    text: 'اضافة',
                    color: AppColor.kPrimary,
                    textColor: AppColor.kWhite,
                    onTap: () {
                      if (image.isNotEmpty) {
                        // BlocProvider.of<AddImagesCubit>(context).nameImage = [];
                        // BlocProvider.of<AddImagesCubit>(context).image = [];
                        Navigator.pop(context);
                      } else {
                        showSankBar(context, 'الرجاء اختيار صورة');
                      }
                    })
                : const CircularProgressIndicator(),
            //
            //end custom button

            SizedBox(height: MediaQuery.of(context).size.height / 20)
          ]);
        },
      ),
    );
  }
}
