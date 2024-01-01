import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/ad_model.dart';
import '../../cubit/cubit/get_ads_cubit.dart';
import 'ad_application.dart';

class AdComponent extends StatefulWidget {
  const AdComponent({
    super.key,
  });

  @override
  State<AdComponent> createState() => _AdComponentState();
}

class _AdComponentState extends State<AdComponent> {
  @override
  void initState() {
    BlocProvider.of<GetAdsCubit>(context).getAd();
    super.initState();
  }

  int inIndex = 0;
  List<AdModel> adList = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAdsCubit, GetAdsState>(
      listener: (context, state) {
        if (state is GetAdsSuccess) {
          adList = state.adList;
          isLoading = false;
        } else if (state is GetAdsLoading) {
          isLoading = true;
        } else if (state is GetAdsFailure) {
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            isLoading != true
                ? adList.isNotEmpty
                    ? CarouselSlider.builder(
                        itemCount: adList.length,
                        itemBuilder: (context, index, realIndex) {
                          return AdApplication(
                            image: adList[index].image,
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          onPageChanged: (index, reason) {
                            setState(() {
                              inIndex = index;
                            });
                          },
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                        ),
                      )
                    : const SizedBox()
                : const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator())),
            AnimatedSmoothIndicator(
                effect: const ExpandingDotsEffect(
                  dotWidth: 9,
                  dotHeight: 5,
                  dotColor: Color(0xff7985CB),
                ),
                activeIndex: inIndex,
                count: adList.length),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
