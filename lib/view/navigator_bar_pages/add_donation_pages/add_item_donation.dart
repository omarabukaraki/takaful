import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/component/custom_search_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/cubit/add_image_cubit/add_image_cubit.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_details_post_page.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/type_of_item_or_service.dart';

class AddItemDonation extends StatelessWidget {
  AddItemDonation({super.key});
  static String id = 'AddItemDonation';
  final List<String> item = [
    AppString.textFood,
    AppString.textClothes,
    AppString.textFurniture,
    AppString.textOther
  ];
  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: CustomAppBar(
        textOne: AppString.textWhatsYouDonation,
        textTwo: AppString.textChooseTheCategoryToAddDonation,
        button: true,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CustomSearchBar(
            hintText: AppString.textSearchInCategory,
            icon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 21),
        TypeOfItemOrService(
          title: AppString.textFood,
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [item[0], category]);
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: AppString.textClothes,
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [item[1], category]);
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: AppString.textFurniture,
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [item[2], category]);
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: AppString.textOther,
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [item[3], category]);
          },
        ),
      ]),
    );
  }
}
