import 'request_donation_process.dart';
import 'widget/image_count.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_strings.dart';
import '../../data/model/donation_model.dart';
import 'widget/donation_details_widget/request_button.dart';
import 'widget/donation_details_widget/discrption_box.dart';
import 'widget/donation_details_widget/donar_account_box.dart';
import 'widget/donation_details_widget/donation_details_info.dart';
import 'widget/donation_details_widget/donation_details_image.dart';
import 'widget/donation_details_widget/donation_details_button.dart';
import 'widget/donation_details_widget/title_donation_details_page.dart';

class DonationDetailsPage extends StatefulWidget {
  const DonationDetailsPage({super.key, this.donationModel, this.docId});
  final DonationModel? donationModel;
  final String? docId;
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
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Stack(children: [
                //start display images the donation
                CarouselSlider.builder(
                  itemCount: widget.donationModel!.image.length,
                  itemBuilder: (context, index, realIndex) {
                    return DonationDetailsImage(
                      image: widget.donationModel!.image[index],
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ImageCount(
                      countImage: inIndex + 1,
                      height: 25,
                    ),
                  ),
                ),
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
                    Text(
                      widget.donationModel!.title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ), //
                    //
                    //

                    widget.donationModel!.id !=
                            FirebaseAuth.instance.currentUser!.uid
                        ? widget.donationModel!.typeOfDonation != 'مطلوب'
                            ? RequestDonationProcess(
                                donationModel: widget.donationModel,
                                docId: widget.docId,
                              )
                            : const RequestButton(
                                nameButton: 'اظهار رقم الهاتف',
                              )
                        : RequestButton(
                            nameButton: 'رجوع',
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),

                    //
                    //
                    //
                    const TitleDonationDetailsPage(text: 'المعلومات'),
                    DonationDetailsInformation(
                        section: 'القسم',
                        data:
                            "${widget.donationModel!.category} - ${widget.donationModel!.itemOrService}"),
                    DonationDetailsInformation(
                        section: AppString.textLocation,
                        data:
                            "${widget.donationModel!.location} - ${widget.donationModel!.subLocation}"),
                    DonationDetailsInformation(
                        section: 'نوع التبرع',
                        data: widget.donationModel!.typeOfDonation),
                    DonationDetailsInformation(
                        section: AppString.textState,
                        data: widget.donationModel!.state),
                    DonationDetailsInformation(
                        section: 'تاريخ النشر',
                        data: widget.donationModel!.createAt.substring(0, 10)),
                    widget.donationModel!.itemOrService.length <= 5
                        ? DonationDetailsInformation(
                            section: AppString.textCounter,
                            data: widget.donationModel!.count.toString())
                        : const SizedBox(),
                    const TitleDonationDetailsPage(text: 'الوصف'),
                    DescriptionBox(widget: widget),
                    const TitleDonationDetailsPage(text: ''),
                    DonarAccountBox(widget: widget),
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
