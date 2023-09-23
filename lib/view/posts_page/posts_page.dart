// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/cubit/post_cubit/post_cubit.dart';
import 'package:takaful/models/post_model.dart';
import 'package:takaful/view/posts_page/post_screen.dart';
import 'package:takaful/view/posts_page/post_component.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});
  static String id = 'PostPage';

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isLodging = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostCubit>(context).getPost();
  }

  List<PostModel> posts = [];
  @override
  Widget build(BuildContext context) {
    List<dynamic> categoryAndItemName =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is PostLodging) {
          isLodging = true;
        } else if (state is PostSuccess) {
          posts = state.posts;
          isLodging = false;
        } else if (state is PostFailure) {
          isLodging = false;
          print('falier');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            button: true,
            textOne: categoryAndItemName[1].toString(),
            textTwo: '',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          body: BlurryModalProgressHUD(
            inAsyncCall: isLodging,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return categoryAndItemName[1] == posts[index].itemOrService
                    ? CustomPostComponent(
                        posts: posts[index],
                        onTapRequest: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PostScreen(postModel: posts[index]);
                          }));
                        },
                      )
                    : const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }
}
