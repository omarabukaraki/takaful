import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          } else if (state is PostFailure) {
            isLoading = false;
          }
        },
        builder: (context, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: isLoading,
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 164,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: kPrimary),
                  child: const Icon(
                    Icons.camera_enhance,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
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
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kTextFiled,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (counter < 500) {
                                        counter++;
                                      } else {
                                        counter = 500;
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.add)),
                              counter == 0
                                  ? const Text(
                                      'العدد',
                                      style: TextStyle(color: kTextFiledFont),
                                    )
                                  : Text(counter.toString()),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (counter > 0) {
                                        counter--;
                                      } else {
                                        counter = 0;
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.remove)),
                            ]),
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
                        image: 'sss',
                        category: categoryAndItemService[1],
                        itemOrService: categoryAndItemService[0],
                        description: description.text,
                        location: location.text,
                        state: stateOfThePost.text,
                        count: counter,
                      );
                    }
                    counter = 0;
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
