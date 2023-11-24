import '../../../donation_request/presentation/cubit/get_donation_request/get_request_from_user/get_request_from_user_cubit.dart';
import '../cubit/request_donation/request_donation_cubit.dart';
import 'widget/image_count.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_strings.dart';
import '../../data/model/donation_model.dart';
import 'widget/donation_details_widget/request_button.dart';
import 'widget/donation_details_widget/discrption_box.dart';
import 'widget/donation_details_widget/donar_account_box.dart';
import 'widget/donation_details_widget/donation_details_info.dart';
import '../../../donation_request/data/model/request_donation.dart';
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
                        ? RequestDonationProcess(
                            donationModel: widget.donationModel,
                            docId: widget.docId,
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

// class CancelRequestButton extends StatelessWidget {
//   const CancelRequestButton(
//       {super.key, this.nameButton, this.isRequest, this.onTap});
//   final String? nameButton;
//   final bool? isRequest;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 40,
//         margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10), color: AppColor.kRed),
//         child: Center(
//             child: Text(
//           nameButton ?? 'طلب',
//           style: const TextStyle(
//             fontSize: 16,
//             color: AppColor.kWhite,
//             fontWeight: FontWeight.bold,
//           ),
//         )),
//       ),
//     );
//   }
// }

class RequestDonationProcess extends StatefulWidget {
  const RequestDonationProcess({super.key, this.donationModel, this.docId});
  final String? docId;
  final DonationModel? donationModel;

  @override
  State<RequestDonationProcess> createState() => _RequestDonationProcessState();
}

class _RequestDonationProcessState extends State<RequestDonationProcess> {
  @override
  void initState() {
    // BlocProvider.of<GetDonationRequestCubit>(context).getRequest();
    BlocProvider.of<GetRequestFromUserCubit>(context)
        .getRequestFromUser(donarId: widget.donationModel!.id);
    super.initState();
  }

  RequestDonationModel? request;
  String? requestId;
  bool checker = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetRequestFromUserCubit, GetRequestFromUserState>(
      builder: (context, state) {
        return (checker)
            ? RequestButton(
                color: Colors.green,
                nameButton: 'الغاء الطلب',
                onTap: () async {
                  checker = false;
                  await BlocProvider.of<GetRequestFromUserCubit>(context)
                      .deleteRequest(
                          donarId: widget.donationModel!.id, docId: requestId!);
                  // await BlocProvider.of<RequestDonationCubit>(context)
                  //     .deleteRequest(docId: requestId!);
                },
              )
            : RequestButton(
                onTap: () async {
                  await BlocProvider.of<RequestDonationCubit>(context)
                      .requestThePost(
                          donarId: widget.donationModel!.id.toString(),
                          donationId: widget.docId.toString(),
                          titleDonation: widget.donationModel!.title,
                          donarAccount: widget.donationModel!.donarAccount,
                          serviceReceiveAccount: FirebaseAuth
                              .instance.currentUser!.email
                              .toString());
                  // await BlocProvider.of<RequestDonationCubit>(context).request(
                  //     donationId: widget.docId.toString(),
                  //     titleDonation: widget.donationModel!.title,
                  //     donarAccount: widget.donationModel!.donarAccount,
                  //     serviceReceiveAccount:
                  //         FirebaseAuth.instance.currentUser!.email.toString());
                },
              );
      },
      listener: (context, state) {
        if (state is GetRequestFromUserSuccess) {
          for (int i = 0; i < state.requests.length; i++) {
            if (state.requests[i].donationId == widget.docId &&
                state.requests[i].serviceReceiverAccount ==
                    FirebaseAuth.instance.currentUser!.email) {
              request = state.requests[i];
              requestId = state.requestId[i];
              checker = true;
            } else {}
          }
        }
      },
    );
  }
}
