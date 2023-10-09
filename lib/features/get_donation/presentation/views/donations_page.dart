// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/donation_details_page.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_component.dart';

class DonationsPage extends StatefulWidget {
  const DonationsPage({super.key});
  static String id = 'PostsPage';

  @override
  State<DonationsPage> createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> {
  bool isLodging = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetDonationCubit>(context).getPost();
  }

  List<DonationModel> donation = [];
  @override
  Widget build(BuildContext context) {
    List<dynamic> categoryAndItemName =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return BlocConsumer<GetDonationCubit, GetDonationState>(
      listener: (context, state) {
        if (state is GetDonationLodging) {
          isLodging = true;
        } else if (state is GetDonationSuccess) {
          donation = state.donations;
          isLodging = false;
        } else if (state is GetDonationFailure) {
          isLodging = false;
          print('failure');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            button: true,
            textOne: categoryAndItemName[1].toString(),
            textTwo: '',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          body: BlurryModalProgressHUD(
            inAsyncCall: isLodging,
            child: Column(
              children: [
                const OrderAndFilter(),
                Expanded(
                  child: ListView.builder(
                    itemCount: donation.length,
                    itemBuilder: (context, index) {
                      return categoryAndItemName[1] ==
                              donation[index].itemOrService
                          ? DonationComponent(
                              donation: donation[index],
                              onTapRequest: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DonationDetailsPage(
                                      postModel: donation[index]);
                                }));
                              },
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderAndFilter extends StatelessWidget {
  const OrderAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: [
          Expanded(child: OrderButton(onTap: () {
            // ignore: avoid_print
            print('order');
          })),
          Expanded(
              flex: 2,
              child: FilterResultButton(
                onTap: () {
                  //ignore: avoid_print
                  print('filter the result');
                },
              )),
        ]),
      ),
    );
  }
}

class FilterResultButton extends StatelessWidget {
  const FilterResultButton({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.kPrimary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColor.kPrimary,
              ),
              Text(
                'فلترة النتائج',
                style: TextStyle(fontSize: 16, color: AppColor.kPrimary),
              ),
              Icon(Icons.filter_alt_rounded, color: AppColor.kPrimary)
            ]),
      ),
    );
  }
}

class OrderButton extends StatelessWidget {
  const OrderButton({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.kPrimary)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('الترتيب',
                style: TextStyle(fontSize: 16, color: AppColor.kPrimary)),
            Icon(Icons.swap_vert_rounded, color: AppColor.kPrimary)
          ],
        ),
      ),
    );
  }
}
