import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/donation_request/presentation/cubit/cubit/request_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/discrption_box.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/donar_account_box.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/request_button.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/title_donation_details_page.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/image_count.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/donation_details_button.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/donation_details_image.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/donation_details_info.dart';

class DonationDetailsPage extends StatefulWidget {
  const DonationDetailsPage({super.key, this.postModel});
  final DonationModel? postModel;
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
                  itemCount: widget.postModel!.image.length,
                  itemBuilder: (context, index, realIndex) {
                    return DonationDetailsImage(
                      image: widget.postModel!.image[index],
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
                      widget.postModel!.title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    widget.postModel!.donarAccount !=
                            FirebaseAuth.instance.currentUser!.email!
                        ? isRequest != true
                            ? RequestButton(
                                onTap: () {
                                  showSankBar(context, 'تم الطلب بنجاح',
                                      color: AppColor.kGreen);
                                  BlocProvider.of<RequestDonationCubit>(context)
                                      .request(
                                          // postId: '',
                                          titleDonation:
                                              widget.postModel!.title,
                                          donarAccount:
                                              widget.postModel!.donarAccount,
                                          serviceReceiveAccount: FirebaseAuth
                                              .instance.currentUser!.email!);
                                  setState(() {
                                    isRequest = true;
                                  });
                                },
                              )
                            : RequestButton(
                                nameButton: 'الغاء الطلب',
                                onTap: () {
                                  setState(() {
                                    isRequest = false;
                                  });
                                  showSankBar(context, 'الغاء الطلب');
                                })
                        : RequestButton(onTap: () {
                            showSankBar(context, 'لا يمكنك طلب هاذ التبرع');
                          }),
                    const TitleDonationDetailsPage(text: 'المعلومات'),
                    DonationDetailsInformation(
                        section: 'القسم',
                        data:
                            "${widget.postModel!.category} - ${widget.postModel!.itemOrService}"),
                    DonationDetailsInformation(
                        section: 'الموقع', data: widget.postModel!.location),
                    DonationDetailsInformation(
                        section: 'الحالة', data: widget.postModel!.state),
                    DonationDetailsInformation(
                        section: 'تاريخ النشر',
                        data: widget.postModel!.createAt.substring(0, 10)),
                    widget.postModel!.itemOrService.length <= 5
                        ? DonationDetailsInformation(
                            section: 'العدد',
                            data: widget.postModel!.count.toString())
                        : const SizedBox(),
                    const TitleDonationDetailsPage(text: 'الوصف'),
                    DescriptionBox(widget: widget),
                    const TitleDonationDetailsPage(text: 'حساب المتبرع'),
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
