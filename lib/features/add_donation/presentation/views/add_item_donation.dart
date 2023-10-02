import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_search_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/add_donation/presentation/cubit/add_images_cubit/add_images_cubit.dart';
import 'package:takaful/features/add_donation/presentation/views/add_details_donation.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/type_of_item_or_service.dart';

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
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CustomSearchBar(
            hintText: AppString.textSearchInCategory,
            icon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
            child: ListView.builder(
          itemCount: item.length,
          itemBuilder: (context, index) {
            return TypeOfItemOrService(
              title: item[index],
              onTap: () {
                BlocProvider.of<GetUserDetailsCubit>(context).getUserDetails();
                BlocProvider.of<AddImagesCubit>(context).url = [];
                Navigator.pushNamed(context, AddDetailsPost.id,
                    arguments: [item[index], category]);
              },
            );
          },
        ))
      ]),
    );
  }
}
