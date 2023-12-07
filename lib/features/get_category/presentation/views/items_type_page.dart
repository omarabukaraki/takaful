import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takaful/features/get_category/presentation/views/widget/category_menu.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/core/widgets/custom_search_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/get_donation/presentation/views/donations_page.dart';

class ItemTypePage extends StatefulWidget {
  const ItemTypePage({super.key});
  static String id = 'ItemTypePage';

  @override
  State<ItemTypePage> createState() => _ItemTypePageState();
}

class _ItemTypePageState extends State<ItemTypePage> {
  var searchName = '';
  @override
  Widget build(BuildContext context) {
    String categoryName = ModalRoute.of(context)!.settings.arguments as String;
    double screenheigth = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> categoryStream = FirebaseFirestore.instance
        .collection('category')
        .orderBy('createAt')
        .snapshots();

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
                margin: const EdgeInsets.only(top: 80),
                width: 100,
                height: screenheigth,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(38)),
                    color: AppColor.kPrimary),
              ),
            ),
          ],
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomSearchBar(
                onChanged: (value) {
                  setState(() {
                    searchName = value;
                  });
                },
                icon: const Icon(Icons.search),
                hintText: 'ابحث في تكافل'),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: searchName != ''
                  ? FirebaseFirestore.instance
                      .collection('category')
                      .orderBy('categoryName')
                      .startAt([searchName]).endAt(
                          ["$searchName\uf8ff"]).snapshots()
                  : categoryStream,
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
                          Navigator.pushNamed(context, DonationsPage.id,
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
