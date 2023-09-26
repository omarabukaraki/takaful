import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/component/custom_search_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/cubit/add_images_cubit/add_images_cubit.dart';
import '../../../../component/custom_app_bar.dart';
import 'widgets/type_of_item_or_service.dart';
import 'add_details_donation.dart';

class AddServiceDonation extends StatelessWidget {
  AddServiceDonation({super.key});
  static String id = 'AddServiceDonation';
  final List<String> service = [
    AppString.textBlacksmithServices,
    AppString.textElectricalServices,
    AppString.textPlumbingServices,
    AppString.textCarpentryServices,
    AppString.textOtherServices,
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
          itemCount: service.length,
          itemBuilder: (context, index) {
            return TypeOfItemOrService(
              title: service[index],
              onTap: () {
                BlocProvider.of<AddImagesCubit>(context).url = [];
                Navigator.pushNamed(context, AddDetailsPost.id,
                    arguments: [service[index], category]);
              },
            );
          },
        )),
      ]),
    );
  }
}
