import 'package:flutter/material.dart';
import 'package:takaful/component/custom_search_bar.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_item_donation.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/type_of_item_or_service.dart';
import 'add_service_donation.dart';

class AddDonation extends StatelessWidget {
  const AddDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          button: false,
          textOne: 'ما الذي تود التبرع به',
          textTwo: 'اختر القسم المناسب لإضافة التبرع '),
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CustomSearchBar(
            hintText: 'إبحث في  القسم',
            icon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 21),
        TypeOfItemOrService(
          title: 'الاستهلاكيات',
          onTap: () {
            Navigator.pushNamed(context, AddItemDonation.id,
                arguments: 'الاستهلاكيات');
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: 'الخدمات',
          onTap: () {
            Navigator.pushNamed(context, AddServiceDonation.id,
                arguments: 'الخدمات');
          },
        ),
        const SizedBox(height: 10),
        const TypeOfItemOrService(title: 'أخرى')
      ]),
    );
  }
}
