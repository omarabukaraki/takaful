import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_search_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/add_donation/presentation/cubit/add_images_cubit/add_images_cubit.dart';
import 'package:takaful/features/get_category/presentation/cubit/cubit/get_category_cubit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../get_category/data/model/category_model.dart';
import 'widgets/type_of_item_or_service.dart';
import 'add_details_donation.dart';

class AddServiceDonation extends StatefulWidget {
  const AddServiceDonation({super.key});
  static String id = 'AddServiceDonation';

  @override
  State<AddServiceDonation> createState() => _AddServiceDonationState();
}

class _AddServiceDonationState extends State<AddServiceDonation> {
  @override
  void initState() {
    BlocProvider.of<GetCategoryCubit>(context).getCategories(isItem: false);
    super.initState();
  }

  List<CategoryModel> categories = [];
  bool isLoading = false;

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
        BlocConsumer<GetCategoryCubit, GetCategoryState>(
          listener: (context, state) {
            if (state is GetCategorySuccess) {
              categories = state.categoryList;
              isLoading = false;
            } else if (state is GetCategoryLoading) {
              isLoading = true;
            } else if (state is GetCategoryFailure) {
              isLoading = false;
            }
          },
          builder: (context, state) {
            return isLoading != true
                ? Expanded(
                    child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return categories[index].title != null
                          ? TypeOfItemOrService(
                              title: categories[index].title != null
                                  ? categories[index].title!
                                  : '',
                              onTap: () {
                                BlocProvider.of<AddImagesCubit>(context).url =
                                    [];
                                Navigator.pushNamed(context, AddDetailsPost.id,
                                    arguments: [
                                      categories[index].title,
                                      category
                                    ]);
                              },
                            )
                          : const SizedBox();
                    },
                  ))
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    );
  }
}
