import 'package:flutter/material.dart';
import 'package:takaful/view/posts_page/posts_page.dart';

import '../../component/category_menu.dart';
import '../../component/custom_app_bar.dart';
import '../../component/custom_search_bar.dart';
import '../../constant.dart';

// ignore: must_be_immutable
class ServiceTypePage extends StatelessWidget {
  ServiceTypePage({super.key});
  static String id = 'ServiceTypePage';
  List<List<String>> itemType = [
    ['assets/image/hedada.png', 'خدمات حدادة'],
    ['assets/image/kahraba.png', 'خدمات كهربائية'],
    ['assets/image/sebaka.jpg', 'خدمات سباكة'],
    ['assets/image/nejara1.jpg', 'خدمات نجارة'],
    ['assets/image/other.png', 'خدمات أخرى'],
  ];
  @override
  Widget build(BuildContext context) {
    String categoryName = ModalRoute.of(context)!.settings.arguments as String;
    double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        textOne: 'الخدمات',
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
                margin: const EdgeInsets.only(top: 80),
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
                icon: Icon(Icons.search), hintText: 'إبحث في تكافل'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemType.length,
              itemBuilder: (context, index) {
                return CategoryMenu(
                  image: itemType[index][0],
                  text: itemType[index][1],
                  onTap: () {
                    Navigator.pushNamed(context, PostPage.id,
                        arguments: [categoryName, itemType[index][1]]);
                  },
                );
              },
            ),
          )
        ]),
      ]),
    );
  }
}
