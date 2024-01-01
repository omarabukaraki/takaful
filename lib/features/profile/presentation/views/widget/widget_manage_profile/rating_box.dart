import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import '../../../../../get_donation/presentation/views/widget/donation_details_widget/custom_rating_bar.dart';

class RatingBox extends StatelessWidget {
  const RatingBox({
    super.key,
    required this.user,
  });

  final List<UserDetailsModel> user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Text('تقييمي', style: TextStyle(color: AppColor.kPrimary)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.kTextFiled,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRatingBar(userDetailsModel: user[0], isRating: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
