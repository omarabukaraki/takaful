import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../donation_request/data/model/request_donation.dart';
import '../../get_donation/data/model/donation_model.dart';
import '../../get_donation/presentation/views/request_donation_process.dart';
import '../../get_donation/presentation/views/widget/donation_details_widget/description_box.dart';
import '../../get_donation/presentation/views/widget/donation_details_widget/donar_account_box.dart';
import '../../get_donation/presentation/views/widget/donation_details_widget/donation_details_button.dart';
import '../../get_donation/presentation/views/widget/donation_details_widget/donation_details_image.dart';
import '../../get_donation/presentation/views/widget/donation_details_widget/donation_details_info.dart';
import '../../get_donation/presentation/views/widget/donation_details_widget/image_count_and_full_count.dart';
import '../../get_donation/presentation/views/widget/donation_details_widget/title_donation_details_page.dart';

class MyRequestDonationDetailsPage extends StatefulWidget {
  const MyRequestDonationDetailsPage(
      {super.key,
      required this.donation,
      required this.docId,
      required this.request});
  final DonationModel donation;
  final String docId;
  final RequestDonationModel request;
  @override
  State<MyRequestDonationDetailsPage> createState() =>
      _MyRequestDonationDetailsPageState();
}

class _MyRequestDonationDetailsPageState
    extends State<MyRequestDonationDetailsPage> {
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
                    widget.request.isApproved != true
                        ? RequestDonationProcess(
                            donationModel: widget.donation,
                            docId: widget.docId,
                          )
                        : Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.kGreen),
                            child: const Center(
                                child: Text(
                              AppString.textAccepted,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.kWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
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
                    DescriptionBox(description: widget.donation.description),
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
