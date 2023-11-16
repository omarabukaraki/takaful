import 'package:flutter/material.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../get_donation/data/model/donation_model.dart';
import '../../../../get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
import '../../../../get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';
import '../../../../get_donation/presentation/views/widget/image_count.dart';

class SaveDonationPage extends StatelessWidget {
  const SaveDonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          button: true,
          onTap: () => Navigator.pop(context),
          textOne: 'الإعلانات المحفوظة',
          textTwo: ''),
      body: const SaveDonationComponent(),
    );
  }
}

class SaveDonationComponent extends StatelessWidget {
  const SaveDonationComponent(
      {super.key, this.onTapEdit, this.onTapDelete, this.donation});

  final DonationModel? donation;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

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
          const Expanded(
              flex: 5,
              child: Row(
                children: [
                  //start information donation
                  Expanded(
                    flex: 1,
                    child: DonationCoverInformation(
                        title:
                            'donation!.title sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
                        typePost:
                            '{donation!.category} - {donation!.itemOrService}',
                        location:
                            '{donation!.location} - {donation!.subLocation}'),
                  ),
                  //end information donation

                  //start image donation
                  Expanded(
                      flex: 1,
                      child: DonationCoverImage(
                        image:
                            'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
                      )),
                  //end image donation
                ],
              )),
          //start display image counter
          const Expanded(flex: 1, child: ImageCount(countImage: 1)),
          // donation!.image.length
          //end display image counter

          //start buttons delete and edit
          Expanded(
              flex: 2,
              child: Row(
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
                          'الغاء الحفظ',
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
                  // Expanded(
                  //   flex: 1,
                  //   child: GestureDetector(
                  //     onTap: onTapEdit,
                  //     child: Container(
                  //       margin: const EdgeInsets.only(top: 5, left: 15),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: AppColor.kPrimary),
                  //       child: const Center(
                  //           child: Text(
                  //         'تعديل',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       )),
                  //     ),
                  //   ),
                  // )
                  // //end edit button
                ],
              ))
          //end buttons delete and edit
        ]),
      ),
    );
  }
}
