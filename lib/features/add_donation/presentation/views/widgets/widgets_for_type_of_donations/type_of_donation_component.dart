import 'package:flutter/material.dart';
import 'package:takaful/features/add_donation/presentation/views/widgets/widgets_for_type_of_donations/type_of_donation_button.dart';

class TypeOfDonationComponent extends StatelessWidget {
  const TypeOfDonationComponent(
      {super.key,
      required this.isSelectedOne,
      required this.isSelectedTwo,
      this.onTapRequired,
      this.onTapShown});

  final bool isSelectedOne;
  final bool isSelectedTwo;
  final VoidCallback? onTapShown;
  final VoidCallback? onTapRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(children: [
        Expanded(
          child: TypeOfDonationButton(
            onTap: onTapShown,
            text: 'معروض',
            isSelectedOne: isSelectedOne,
            isSelectedTwo: !isSelectedTwo,
          ),
        ),
        Expanded(
          child: TypeOfDonationButton(
            onTap: onTapRequired,
            text: 'مطلوب',
            isSelectedOne: !isSelectedOne,
            isSelectedTwo: isSelectedTwo,
          ),
        ),
      ]),
    );
  }
}
