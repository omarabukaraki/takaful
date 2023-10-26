import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class LocationFilter extends StatefulWidget {
  const LocationFilter({super.key});

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  List<String> typeOfDonation = [
    'كل المدن',
    'عمان',
    'إربد',
    'الزرقاء',
    'السلط',
    'المفرق',
    'الكرك',
    'مأدبا',
    'جرش',
    'عجلون',
    'العقبة',
    'معان',
    'الطفيلة',
  ];
  String type = 'كل المدن';
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'الموقع',
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
                      setState(() {
                        type = typeOfDonation[index];
                        currentIndex = index;
                      });
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
