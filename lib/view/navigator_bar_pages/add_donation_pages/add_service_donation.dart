import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/component/custom_search_bar.dart';
import 'package:takaful/cubit/add_image_cubit/add_image_cubit.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/type_of_item_or_service.dart';
import 'add_details_post_page.dart';

// ignore: must_be_immutable
class AddServiceDonation extends StatelessWidget {
  AddServiceDonation({super.key});
  static String id = 'AddServiceDonation';
  List<String> service = [
    'خدمات حدادة',
    'خدمات كهربائية',
    'خدمات سباكة',
    'خدمات نجارة',
    'خدمات أخرى'
  ];
  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: CustomAppBar(
        textOne: 'ما الذي تود التبرع به',
        textTwo: 'اختر القسم المناسب لإضافة التبرع ',
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
            hintText: 'ابحث في  القسم',
            icon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 21),
        TypeOfItemOrService(
          title: 'خدمات حدادة',
          onTap: () {
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [service[0], category]);
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: 'خدمات كهربائية',
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [service[1], category]);
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: 'خدمات سباكة',
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [service[2], category]);
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: 'خدمات نجارة',
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [service[3], category]);
          },
        ),
        const SizedBox(height: 10),
        TypeOfItemOrService(
          title: 'خدمات أخرى',
          onTap: () {
            BlocProvider.of<AddImageCubit>(context).url = [];
            Navigator.pushNamed(context, AddDetailsPost.id,
                arguments: [service[4], category]);
          },
        )
      ]),
    );
  }
}
