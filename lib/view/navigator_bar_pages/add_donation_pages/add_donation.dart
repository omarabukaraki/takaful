import 'package:flutter/material.dart';
import 'package:takaful/component/custom_search_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
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
          textOne: AppString.textWhatsYouDonation,
          textTwo: AppString.textChooseTheCategoryToAddDonation),
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CustomSearchBar(
            hintText: AppString.textSearchInCategory,
            icon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: AppString.textItems,
          onTap: () {
            Navigator.pushNamed(context, AddItemDonation.id,
                arguments: AppString.textItems);
          },
        ),
        TypeOfItemOrService(
          title: AppString.textServices,
          onTap: () {
            Navigator.pushNamed(context, AddServiceDonation.id,
                arguments: AppString.textServices);
          },
        ),
        const TypeOfItemOrService(title: AppString.textOther)
      ]),
    );
  }
}
