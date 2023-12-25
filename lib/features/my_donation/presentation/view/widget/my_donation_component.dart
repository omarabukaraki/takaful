import 'package:flutter/material.dart';
import '../../../../../../../../core/utils/app_colors.dart';
import '../../../../get_donation/data/model/donation_model.dart';
import '../../../../get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
import '../../../../get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';
import '../../../../get_donation/presentation/views/widget/image_count.dart';

class MyDonationComponent extends StatelessWidget {
  const MyDonationComponent(
      {super.key,
      this.onTapEdit,
      this.onTapDelete,
      this.donation,
      this.isTaken});

  final DonationModel? donation;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;
  final bool? isTaken;

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
                  //start information donation
                  Expanded(
                    flex: 1,
                    child: DonationCoverInformation(
                        title: donation!.title,
                        typePost:
                            '${donation!.category} - ${donation!.itemOrService}',
                        location:
                            '${donation!.location} - ${donation!.subLocation}'),
                  ),
                  //end information donation

                  //start image donation
                  Expanded(
                      flex: 1,
                      child: DonationCoverImage(
                        image: donation!.image[0],
                      )),
                  //end image donation
                ],
              )),
          //start display image counter
          Expanded(
              flex: 1, child: ImageCount(countImage: donation!.image.length)),
          //end display image counter

          //start buttons delete and edit
          Expanded(
              flex: 2,
              child: isTaken != true
                  ? Row(
                      children: [
                        //start delete button
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: onTapDelete,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 15),
                              decoration: BoxDecoration(
                                color: AppColor.kRed,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                  child: Text(
                                'حذف',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.kWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                        ),
                        //end delete button

                        //start edit button
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: onTapEdit,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.kPrimary),
                              child: const Center(
                                  child: Text(
                                'تعديل',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                        )
                        //end edit button
                      ],
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 5, left: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.kPrimary),
                      child: const Center(
                          child: Text(
                        'تم التبرع',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))))
          //end buttons delete and edit
        ]),
      ),
    );
  }
}
