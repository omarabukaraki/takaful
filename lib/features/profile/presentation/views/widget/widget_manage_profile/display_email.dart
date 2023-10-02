import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/text_field.dart';

class DisplayEmail extends StatelessWidget {
  const DisplayEmail({
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
            child: Text('البريد الالكتروني',
                style: TextStyle(color: AppColor.kPrimary)),
          ),
          ManageProfileTextField(
              readOnly: true, hintText: user.isNotEmpty ? user[0].email : ''),
        ],
      ),
    );
  }
}
