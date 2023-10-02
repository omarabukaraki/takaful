import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';

class AddImageProfileButton extends StatelessWidget {
  const AddImageProfileButton({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);

  final List<UserDetailsModel> user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(1.1, -1.1),
      children: [
        CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(user.isNotEmpty
                ? user[0].image
                : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f&_gl=1*1p08skf*_ga*MTU3NDc4MjEzNi4xNjk0MDE3NjE4*_ga_CW55HF8NVT*MTY5NjA3NzM3Mi41Mi4xLjE2OTYwNzc4NzMuNTMuMC4w')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.kPrimary),
                child: const Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 16,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
