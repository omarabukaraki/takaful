import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/discrption_box.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/request_button.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/title_donation_details_page.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/image_count.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/donation_details_button.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/donation_details_image.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_widget/donation_details_info.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';

class DonationDetailsPage extends StatefulWidget {
  const DonationDetailsPage({super.key, this.postModel});
  final DonationModel? postModel;
  @override
  State<DonationDetailsPage> createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {
  int inIndex = 0;

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
                DonationDetailsButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ]),
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
                    RequestButton(
                      onTap: () {
                        print('request');
                      },
                    ),
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
            ]),
          ),
        ),
      ),
    );
  }
}

class DonarAccountBox extends StatefulWidget {
  const DonarAccountBox({
    super.key,
    required this.widget,
  });

  final DonationDetailsPage widget;

  @override
  State<DonarAccountBox> createState() => _DonarAccountBoxState();
}

class _DonarAccountBoxState extends State<DonarAccountBox> {
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsCubit>(context)
        .userDonationInformation(email: widget.widget.postModel!.donarAccount);
    super.initState();
  }

  UserDetailsModel? userDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ],
            color: Colors.white),
        child: BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
          listener: (context, state) {
            if (state is GetUserDetailsSuccessForDonation) {
              userDetailsModel = state.user;
            }
          },
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userDetailsModel != null ? userDetailsModel!.name : '',
                        // widget.postModel!.donarName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl: userDetailsModel != null
                            ? userDetailsModel!.image
                            : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f',
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return CircularProgressIndicator(
                              value: downloadProgress.progress);
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )),
              ],
            );
          },
        ));
  }
}
