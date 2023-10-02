import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/image_count.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_button.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_image.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_details_info.dart';

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
                      onTap: () {},
                    ),
                    const HeadersDonationPage(text: 'المعلومات'),
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
                    const HeadersDonationPage(text: 'الوصف'),
                    DescriptionBox(widget: widget),
                    const HeadersDonationPage(text: 'حساب المتبرع'),
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

class HeadersDonationPage extends StatelessWidget {
  const HeadersDonationPage({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text ?? 'الوصف',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    );
  }
}

class DonarAccountBox extends StatelessWidget {
  const DonarAccountBox({
    super.key,
    required this.widget,
  });

  final DonationDetailsPage widget;

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
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.postModel!.donarName,
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
                    image: DecorationImage(
                      image: NetworkImage(widget.postModel!.donarImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ],
        ));
  }
}

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({
    super.key,
    required this.widget,
  });

  final DonationDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      height: 100,
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
      child: Text(
        widget.postModel!.description,
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }
}

class RequestButton extends StatelessWidget {
  const RequestButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: AppColor.kPrimary),
        child: const Center(
            child: Text(
          'طلب',
          style: TextStyle(
            fontSize: 16,
            color: AppColor.kWhite,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
