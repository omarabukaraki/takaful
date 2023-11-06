// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/get_donation/presentation/cubit/save_donation_cubit/save_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/cubit/save_donation_cubit/save_donation_model.dart';
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
  List<String> docId=[] ;
  List<SaveDonationModel> savedDonation = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetDonationCubit>(context).getPost();
    BlocProvider.of<SaveDonationCubit>(context).getSavedDonation();
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
          docId = state.docId;
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
                BlocConsumer<SaveDonationCubit, SaveDonationState>(
                  listener: (context, state) {
                  if(state is SaveDonationSuccess){
                    savedDonation = state.donationSaved;
                  }                  },
                  builder: (context, state) {
                    return Expanded(
                                  child: ListView.builder(
                                    itemCount: donation.length,
                                    itemBuilder: (context, index) {
                                      return categoryAndItemName[1] ==
                                              donation[index].itemOrService
                                          ? DonationComponent(isSaved:savedDonation[index].donationId!=''  && FirebaseAuth.instance.currentUser!.uid == savedDonation[index].userId ? true : false,
                                            onTapSave: () async{ 
                                              setState(() {
                                                
                                              });
                                           await BlocProvider.of<SaveDonationCubit>(context).saveDonation(docId: docId[index]);
                                            },
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
                                );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// if(donation_id == donation_id from request and user_id == user_id)