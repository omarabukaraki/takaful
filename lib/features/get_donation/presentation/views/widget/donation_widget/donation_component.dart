import 'package:flutter/material.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/image_count.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';

class DonationComponent extends StatelessWidget {
  const DonationComponent(
      {super.key,
      this.onTapRequest,
      this.onTapSave,
      this.donation,
      this.isSaved});

  final DonationModel? donation;
  final VoidCallback? onTapRequest;
  final VoidCallback? onTapSave;
  final bool? isSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DonationCoverInformation(
                      title: donation!.title,
                      typePost:
                          '${donation!.category} - ${donation!.itemOrService}',
                      location:
                          '${donation!.location} - ${donation!.subLocation}',
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: DonationCoverImage(
                        image: donation!.image[0],
                      )),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Container(
                  //   width: 95,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: AppColor.kFontSecondary,
                  //   ),
                  //   child: Center(
                  //       child: Text(
                  //     donation!.typeOfDonation.toString(),
                  //     style: const TextStyle(color: AppColor.kWhite),
                  //   )),
                  // ),
                  // const SizedBox(width: 10),
                  ImageCount(countImage: donation!.image.length),
                ],
              )),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  isSaved != true
                      ? Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: onTapSave,
                            child: const CustomButtonToDonationComponent(),
                          ),
                        )
                      : Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: const CustomButtonToDonationComponent(
                              text: 'تم الحفظ',
                              color: AppColor.kGreen,
                            ),
                          ),
                        ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapRequest,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.kPrimary),
                        child: const Center(
                            child: Text(
                          'عرض',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}

class CustomButtonToDonationComponent extends StatelessWidget {
  const CustomButtonToDonationComponent({super.key, this.text, this.color});
  final String? text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 5, left: 15),
      decoration: BoxDecoration(
        border: Border.all(color: color ?? AppColor.kPrimary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        text ?? 'حفظ',
        style: TextStyle(
          fontSize: 16,
          color: color ?? AppColor.kPrimary,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
