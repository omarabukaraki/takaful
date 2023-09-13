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
  String? title;
  String? location;
  String? state;
  String? count;
  String? description;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

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
      body: BlurryModalProgressHUD(
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
              onChanged: (postTitle) {
                title = postTitle;
              },
              hintText: 'العنوان',
              icon: const Icon(Icons.title_rounded),
            ),
            CustomTextFiled(
              onChanged: (postLocation) {
                location = postLocation;
              },
              hintText: 'الموقع',
              icon: const Icon(Icons.location_on),
            ),
            CustomTextFiled(
              onChanged: (postState) {
                state = postState;
              },
              hintText: 'الحالة',
              icon: const Icon(Icons.fiber_new_rounded),
            ),
            // categoryAndItemService[0].length <= 5
            //     ?

            CustomTextFiled(
              onChanged: (postCount) {
                count = postCount;
              },
              typeKeyboardNumber: true,
              hintText: 'العدد',
              icon: const Icon(Icons.format_list_numbered_outlined),
            )
            // : const SizedBox(),
            ,
            CustomTextFiled(
              onChanged: (postDescription) {
                description = postDescription;
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
                  setState(() {
                    isLoading = true;
                  });
                  BlocProvider.of<PostCubit>(context).addPost(
                      postState: true,
                      title: title!,
                      image: 'sss',
                      category: categoryAndItemService[1],
                      itemOrService: categoryAndItemService[0],
                      description: description!,
                      location: location!,
                      state: state!,
                      count: int.parse(count!));
                  setState(() {
                    isLoading = false;
                  });
                }
                // if (formKey.currentState!.validate()) {
                //   setState(() {
                //     isLoading = true;
                //   });
                //   CollectionReference collRef =
                //       FirebaseFirestore.instance.collection('post');
                //   collRef.add({
                //     'id': FirebaseAuth.instance.currentUser!.uid,
                //     'postState': true,
                //     'title': title,
                //     'images': '',
                //     'category': categoryAndItemService[1],
                //     'itemOrService': categoryAndItemService[0],
                //     'count': int.parse(count!),
                //     'description': description,
                //     'location': location,
                //     'state': state,
                //     'createAt': DateTime.now(),
                //     'donerAccount':
                //         FirebaseAuth.instance.currentUser!.email.toString(),
                //   });
                //   await Future.delayed(const Duration(seconds: 2));
                //   setState(() {
                //     isLoading = false;
                //   });
                // }

                // print(collRef);
              },
              textColor: Colors.white,
              color: kPrimary,
            ),
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
