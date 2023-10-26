// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import '../../data/model/donation_model.dart';
import '../cubit/get_donation_cubit/get_donation_cubit.dart';
import 'donation_details_page.dart';
import 'widget/donation_widget/donation_component.dart';
import 'widget/filter_widget/order_and_filter.dart';

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
