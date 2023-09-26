import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/get_donation/presentation/views/donations_page.dart';
import 'widget/category_menu.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_search_bar.dart';

class ServiceTypePage extends StatelessWidget {
  const ServiceTypePage({super.key});
  static String id = 'ServiceTypePage';

  @override
  Widget build(BuildContext context) {
    String categoryName = ModalRoute.of(context)!.settings.arguments as String;
    double screenheigth = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> categoryStream = FirebaseFirestore.instance
        .collection('service category')
        .orderBy('createAt')
        .snapshots();
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
                    color: AppColor.kPrimary),
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
                          Navigator.pushNamed(context, DonationsPage.id,
                              arguments: [categoryName, data['categoryName']]);
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ]),
      ]),
    );
  }
}
