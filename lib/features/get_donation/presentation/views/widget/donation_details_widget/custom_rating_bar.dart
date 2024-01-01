import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({
    super.key,
    this.isRating = false,
    required this.userDetailsModel,
  });

  final UserDetailsModel? userDetailsModel;
  final bool isRating;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isRating != true
            ? const Text(
                'تقييم',
                style: TextStyle(color: AppColor.kPrimary, fontSize: 15),
              )
            : const SizedBox(),
        const SizedBox(width: 8),
        Text('(${userDetailsModel!.numberOfRatingUsers})'),
        const SizedBox(width: 5),
        Directionality(
          textDirection: TextDirection.rtl,
          child: RatingBar.builder(
            ignoreGestures: true,
            itemSize: 20,
            initialRating: userDetailsModel!.rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ),
      ],
    );
  }
}
