import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../cubit/add_image_to_verification_account_cubit/add_image_to_verification_account_cubit.dart';
import 'image_button.dart';

class AddImageComponent extends StatefulWidget {
  const AddImageComponent({
    super.key,
  });

  @override
  State<AddImageComponent> createState() => _AddImageComponentState();
}

String? url;
bool isLoading = false;

class _AddImageComponentState extends State<AddImageComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddImageToVerificationAccountCubit,
        AddImageToVerificationAccountState>(
      listener: (context, state) {
        if (state is AddImageToVerificationAccountSuccess) {
          url = state.url;
          state.url = '';
          isLoading = false;
        } else if (state is AddImageToVerificationAccountLoading) {
          isLoading = true;
        } else if (state is AddImageToVerificationAccountFailure) {
          isLoading = false;
        }
      },
      builder: (context, state) {
        return isLoading != true
            ? url == null
                ? GestureDetector(
                    onTap: () async {
                      await BlocProvider.of<AddImageToVerificationAccountCubit>(
                              context)
                          .pickImageFromGallery();
                    },
                    child: const ImageButton(
                        icon: Icons.image, text: 'أضف وثيقة تسجيل الجمعية'))
                : Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: double.infinity,
                    height: 180,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.network(url!, fit: BoxFit.cover),
                  )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                    color: AppColor.kPrimary,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: CircularProgressIndicator(color: AppColor.kWhite)),
              );
      },
    );
  }
}
