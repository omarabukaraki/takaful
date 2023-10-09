import 'package:flutter/material.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/image_count.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';

class DonationComponent extends StatelessWidget {
  const DonationComponent(
      {super.key, this.onTapRequest, this.onTapSave, this.donation});
  final DonationModel? donation;

  final VoidCallback? onTapRequest;
  final VoidCallback? onTapSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 190,
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
                        location: donation!.location),
                  ),
                  Expanded(
                      flex: 1,
                      child: DonationCoverImage(
                        image: donation!.image[0],
                      )),
                ],
              )),
          Expanded(
              flex: 1, child: ImageCount(countImage: donation!.image.length)),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapSave,
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.kPrimary),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Text(
                          'حفظ',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.kPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
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
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.kPrimary),
                        child: const Center(
                            child: Text(
                          'طلب',
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