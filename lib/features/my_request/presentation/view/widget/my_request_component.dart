import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import '../../../../get_donation/data/model/donation_model.dart';
import '../../../../get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
import '../../../../get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';
import '../../../../get_donation/presentation/views/widget/image_count.dart';

class MyRequestComponent extends StatelessWidget {
  const MyRequestComponent({super.key, this.onTapRequest, this.donation});

  final DonationModel? donation;
  final VoidCallback? onTapRequest;

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
          //start display donation information
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  //start display information donation
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
                  //end display information donation

                  //start display cover image donation
                  Expanded(
                      flex: 1,
                      child: DonationCoverImage(
                        image: donation!.image[0],
                      )),
                  //end display cover image donation
                ],
              )),
          //end display donation information

          //start display image count
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ImageCount(countImage: donation!.image.length),
                ],
              )),
          //end display image count

          //start display donation button
          Expanded(
              flex: 2,
              child: Row(
                children: [
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
          //end display donation button
        ]),
      ),
    );
  }
}
