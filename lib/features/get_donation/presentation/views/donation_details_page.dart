import 'package:takaful/core/utils/app_colors.dart';
import 'helper/custom_alert_Dialog.dart';
import 'request_donation_process.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_strings.dart';
import '../../data/model/donation_model.dart';
import 'widget/donation_details_widget/image_count_and_full_count.dart';
import 'widget/donation_details_widget/request_button.dart';
import 'widget/donation_details_widget/description_box.dart';
import 'widget/donation_details_widget/donar_account_box.dart';
import 'widget/donation_details_widget/donation_details_info.dart';
import 'widget/donation_details_widget/donation_details_image.dart';
import 'widget/donation_details_widget/donation_details_button.dart';
import 'widget/donation_details_widget/title_donation_details_page.dart';

class DonationDetailsPage extends StatefulWidget {
  const DonationDetailsPage(
      {super.key, required this.donation, required this.docId});
  final DonationModel donation;
  final String docId;
  @override
  State<DonationDetailsPage> createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {
  int inIndex = 0;
  bool isRequest = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppColor.kWhite,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Stack(children: [
                //start display images the donation
                CarouselSlider.builder(
                  itemCount: widget.donation.image.length,
                  itemBuilder: (context, index, realIndex) {
                    return DonationDetailsImage(
                      image: widget.donation.image[index],
                    );
                  },
                  options: CarouselOptions(
                    // enableInfiniteScroll: false,
                    height: screenWidth < 500 ? 250 : 420,
                    onPageChanged: (index, reason) {
                      setState(() {
                        inIndex = index;
                      });
                    },
                    viewportFraction: 1,
                  ),
                ),
                //end display images the donation

                //start image counter
                ImageCountAndFullCount(
                    fullCountImage: widget.donation.image.length,
                    countImage: inIndex + 1,
                    height: 25),
                //end image counter

                //start button to return to donations page
                DonationDetailsButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                //end button to return to donations page
              ]),
              //start body of donation details page
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //start title donation
                    Text(
                      widget.donation.title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                    ),
                    //end title donation

                    //start request button
                    widget.donation.id != FirebaseAuth.instance.currentUser!.uid
                        ? widget.donation.typeOfDonation !=
                                AppString.textRequired
                            ? RequestDonationProcess(
                                donationModel: widget.donation,
                                docId: widget.docId,
                              )
                            : RequestButton(
                                nameButton: 'اجراء مكالمة',
                                onTap: () async {
                                  // await FlutterPhoneDirectCaller.callNumber(
                                  //     '0786996089');
                                  alertDialogPhone(context).show();
                                },
                              )
                        : RequestButton(
                            nameButton: 'رجوع',
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                    //end request button

                    //start information  title
                    const TitleDonationDetailsPage(
                        text: AppString.textInformation),
                    //end information  title

                    //start information  body
                    DonationDetailsInformation(
                        section: AppString.textSection,
                        data:
                            "${widget.donation.category} - ${widget.donation.itemOrService}"),
                    DonationDetailsInformation(
                        section: AppString.textLocation,
                        data:
                            "${widget.donation.location} - ${widget.donation.subLocation}"),
                    DonationDetailsInformation(
                        section: AppString.textTypeOfDonation,
                        data: widget.donation.typeOfDonation),
                    DonationDetailsInformation(
                        section: AppString.textState,
                        data: widget.donation.state),
                    DonationDetailsInformation(
                        section: AppString.textPublishDate,
                        data: widget.donation.createAt.substring(0, 10)),
                    widget.donation.itemOrService.length <= 5
                        ? DonationDetailsInformation(
                            section: AppString.textCounter,
                            data: widget.donation.count.toString())
                        : const SizedBox(),
                    //end information  body

                    //start description title and body
                    const TitleDonationDetailsPage(
                        text: AppString.textDescription),
                    //end description title and body

                    //Start donar title and body
                    DescriptionBox(
                      description: widget.donation.description,
                    ),
                    const TitleDonationDetailsPage(
                        text: AppString.textAdvertiser),
                    DonarAccountBox(
                        donarAccount: widget.donation.donarAccount,
                        userId: widget.donation.id),
                    //end donar title and body
                  ],
                ),
              )
              //end body of donation details page
            ]),
          ),
        ),
      ),
    );
  }
}
