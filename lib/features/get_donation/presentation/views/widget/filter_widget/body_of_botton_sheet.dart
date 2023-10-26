import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import 'fulter_button_to_bottn_sheet.dart';
import 'location_filter.dart';
import 'type_of_donation_filter.dart';

class BodyOfBottomSheet extends StatefulWidget {
  const BodyOfBottomSheet({
    super.key,
  });

  @override
  State<BodyOfBottomSheet> createState() => _BodyOfBottomSheetState();
}

class _BodyOfBottomSheetState extends State<BodyOfBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text('فلترة النتائج',
              style: TextStyle(color: AppColor.kPrimary, fontSize: 22)),
          const SizedBox(height: 10),
          const TypeOfDonationFilter(),
          const SizedBox(height: 10),
          const LocationFilter(),
          const SizedBox(height: 30),
          FilterButtonToBottomSheet(
            onTap: () {},
          )
        ]),
      ),
    );
  }
}
