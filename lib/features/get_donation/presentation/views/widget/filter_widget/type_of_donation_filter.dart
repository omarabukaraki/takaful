import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';

import '../../../cubit/get_donation_cubit/get_donation_cubit.dart';

class TypeOfDonationFilter extends StatefulWidget {
  const TypeOfDonationFilter({
    super.key,
  });

  @override
  State<TypeOfDonationFilter> createState() => _TypeOfDonationFilterState();
}

class _TypeOfDonationFilterState extends State<TypeOfDonationFilter> {
  List<String> typeOfDonation = ['الكل', 'مطلوب', 'معروض'];
  String type = 'الكل';

  @override
  Widget build(BuildContext context) {
    int? currentIndex =
        BlocProvider.of<GetDonationCubit>(context).currentIndexType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          AppString.textTypeOfDonation,
          style: TextStyle(color: AppColor.kFont, fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                itemCount: typeOfDonation.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      type = typeOfDonation[index];
                      currentIndex = index;
                      BlocProvider.of<GetDonationCubit>(context)
                          .typeOfDonation = type.toString();
                      BlocProvider.of<GetDonationCubit>(context)
                          .currentIndexType = index;
                      setState(() {});
                    },
                    child: currentIndex == index
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            width: double.infinity,
                            height: 10,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.kPrimary),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.kTextFiled),
                            child: Center(child: Text(typeOfDonation[index])),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            width: double.infinity,
                            height: 10,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.kWhite),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.kTextFiled),
                            child: Center(child: Text(typeOfDonation[index])),
                          ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
