// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takaful/component/custom_app_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> postStream = FirebaseFirestore.instance
        .collection('post')
        .orderBy('createAt', descending: true)
        .snapshots();
    List<dynamic> categoryAndItemName =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return Scaffold(
        appBar: CustomAppBar(
          button: true,
          textOne: categoryAndItemName[1].toString(),
          textTwo: '',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: StreamBuilder(
          stream: postStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return SizedBox(
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return categoryAndItemName[1] == data['itemOrService']
                      ? CustomPostComponent(
                          image: data['image'],
                          location: data['location'],
                          title: data['title'],
                          countImage: 1,
                          typePost:
                              data['category'] + ' , ' + data['itemOrService'],
                          onTapRequest: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PostScreen(
                                postModel: PostModel(
                                  data['id'],
                                  data['postState'],
                                  data['title'],
                                  data['image'],
                                  data['category'],
                                  data['itemOrService'],
                                  data['description'],
                                  data['location'],
                                  data['state'],
                                  data['createAt'],
                                  data['donarAccount'],
                                  data['count'],
                                ),
                              );
                            }));
                          },
                        )
                      : const SizedBox();
                }).toList(),
              ),
            );
          },
        ));
  }
}
