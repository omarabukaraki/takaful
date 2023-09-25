import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:takaful/component/counter_post.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/component/custom_button.dart';
import 'package:takaful/component/custom_textfiled.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/cubit/add_images_cubit/add_images_cubit.dart';
import 'package:takaful/cubit/post_cubit/post_cubit.dart';
import 'package:takaful/helper/show_snak_bar.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_images.dart';

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
  bool addedImage = false;
  List<String> urls = [];
  void clearText() {
    title.clear();
    location.clear();
    stateOfThePost.clear();
    description.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryAndItemService =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
        appBar: CustomAppBar(
          textOne: categoryAndItemService[0],
          textTwo: AppString.textAddDetailsToDonation,
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
              BlocProvider.of<AddImagesCubit>(context).image = [];
              BlocProvider.of<AddImagesCubit>(context).nameImage = [];
              BlocProvider.of<AddImagesCubit>(context).url = [];
              addedImage = false;
            } else if (state is PostFailure) {
              isLoading = false;
            }
          },
          builder: (context, state) {
            return BlurryModalProgressHUD(
              inAsyncCall: isLoading,
              progressIndicator: const SpinKitFadingCircle(
                  color: AppColor.kPrimary, size: 90.0),
              dismissible: false,
              opacity: 0.4,
              child: Form(
                key: formKey,
                child: ListView(children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(right: 29),
                    child: Text(
                      AppString.textAddImageToDonation,
                      style: TextStyle(fontSize: 17, color: AppColor.kFont),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<AddImagesCubit, AddImagesState>(
                    listener: (context, state) {
                      addedImage = true;
                    },
                    builder: (context, state) {
                      return addedImage != true
                          ? GestureDetector(
                              onTap: () {
                                BlocProvider.of<AddImagesCubit>(context).image =
                                    [];
                                BlocProvider.of<AddImagesCubit>(context).url =
                                    [];
                                BlocProvider.of<AddImagesCubit>(context)
                                    .nameImage = [];
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const AddImages();
                                  },
                                ));
                              },
                              child: const AddImage(
                                  icon: Icons.image,
                                  text: AppString.textAddImageToDonation))
                          : const AddImage();
                    },
                  ),
                  CustomTextFiled(
                    controller: title,
                    onChanged: (postTitle) {
                      title.text = postTitle;
                    },
                    hintText: AppString.textTitle,
                    icon: const Icon(Icons.title_rounded),
                  ),
                  CustomTextFiled(
                    controller: location,
                    onChanged: (postLocation) {
                      location.text = postLocation;
                    },
                    hintText: AppString.textLocation,
                    icon: const Icon(Icons.location_on),
                  ),
                  CustomTextFiled(
                    controller: stateOfThePost,
                    onChanged: (p0) {
                      stateOfThePost.text = p0;
                    },
                    hintText: AppString.textState,
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
                    hintText: AppString.textDescription,
                    icon: const Icon(Icons.description),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    circular: 20,
                    text: AppString.textPublishDonation,
                    onTap: () async {
                      if (BlocProvider.of<AddImagesCubit>(context)
                          .url
                          .isEmpty) {
                        showSankBar(context, 'الرجاء اضافة صور',
                            color: AppColor.kRed);
                      } else {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<PostCubit>(context).addPost(
                            postState: true,
                            title: title.text,
                            image: BlocProvider.of<AddImagesCubit>(context).url,
                            category: categoryAndItemService[1],
                            itemOrService: categoryAndItemService[0],
                            description: description.text,
                            location: location.text,
                            state: stateOfThePost.text,
                            count: counter,
                          );
                        }
                      }
                    },
                    textColor: AppColor.kWhite,
                    color: AppColor.kPrimary,
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
              ),
            );
          },
        ));
  }
}

class AddImage extends StatelessWidget {
  const AddImage({
    super.key,
    this.icon,
    this.text,
  });
  final IconData? icon;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 164,
      decoration: BoxDecoration(
          color: AppColor.kPrimary, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.check,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            text ?? 'تم اضافة الصور بنجاح',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}
