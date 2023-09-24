import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takaful/component/category_menu.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/component/custom_search_bar.dart';
import 'package:takaful/constant.dart';
import 'package:takaful/view/posts_page/posts_page.dart';

class ItemTypePage extends StatelessWidget {
  const ItemTypePage({super.key});
  static String id = 'ItemTypePage';

  @override
  Widget build(BuildContext context) {
    String categoryName = ModalRoute.of(context)!.settings.arguments as String;
    double screenheigth = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> categoryStream = FirebaseFirestore.instance
        .collection('category')
        .orderBy('createAt')
        .snapshots();
    //
    return Scaffold(
      appBar: CustomAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        textOne: categoryName,
        textTwo: '',
        button: true,
        sizeFont: 26,
      ),
      backgroundColor: Colors.white,
      body: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 80),
                width: 100,
                height: screenheigth,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(38)),
                    color: kPrimary),
              ),
            ),
          ],
        ),
        Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomSearchBar(
                icon: Icon(Icons.search), hintText: 'ابحث في تكافل'),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: categoryStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return CategoryMenu(
                        image: data['image'],
                        text: data['categoryName'],
                        onTap: () {
                          Navigator.pushNamed(context, PostPage.id,
                              arguments: [categoryName, data['categoryName']]);
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          )
        ]),
      ]),
    );
  }
}
