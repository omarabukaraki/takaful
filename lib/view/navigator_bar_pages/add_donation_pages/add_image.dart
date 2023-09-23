import 'dart:io';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/constant.dart';
import 'package:takaful/cubit/add_image_cubit/add_image_cubit.dart';
import 'package:takaful/helper/show_snak_bar.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool isLodging = false;
  List<File> images = [];
  List<String> urls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
            button: false, textOne: 'أضف صور للتبرع', textTwo: ''),
        body: BlocConsumer<AddImageCubit, AddImageState>(
          listener: (context, state) {
            if (state is AddImageSuccess) {
              isLodging = false;
              images = state.image;
              BlocProvider.of<AddImageCubit>(context).uploadImage();
            } else if (state is AddImageFailure) {
              isLodging = false;
              showSankBar(context, state.errMessage, color: kPrimary);
            }
            if (state is UploadImageLodging) {
              isLodging = true;
            } else if (state is UploadImageSuccess) {
              isLodging = false;
              urls = state.url;
              showSankBar(context, 'تم اضافة الصور بنجاح', color: Colors.green);
              Navigator.pop(context);
            } else if (state is UploadImageFailure) {
              isLodging = false;
              showSankBar(context, state.errMessage, color: kPrimary);
            }
          },
          builder: (context, state) {
            return BlurryModalProgressHUD(
                inAsyncCall: isLodging,
                progressIndicator:
                    const SpinKitFadingCircle(color: kPrimary, size: 90.0),
                dismissible: false,
                opacity: 0.4,
                child: Column(children: [
                  images.isEmpty
                      ? GestureDetector(
                          onTap: () async {
                            BlocProvider.of<AddImageCubit>(context)
                                .pickMultiImageFromGallery();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimary),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                              itemCount: images.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    child: Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: FileImage(images[index]),
                                        fit: BoxFit.cover),
                                  ),
                                ));
                              }),
                        ),
                ]));
          },
        ));
  }
}
