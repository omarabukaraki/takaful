import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../donation_request/data/model/request_donation.dart';
import '../../../../get_donation/data/model/donation_model.dart';
import '../../../../get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import '../../../../get_donation/presentation/views/donation_details_page.dart';
import 'my_request_component.dart';

class MyRequestProcess extends StatefulWidget {
  const MyRequestProcess({
    super.key,
    this.requestId,
    this.index,
    required this.request,
  });
  final RequestDonationModel request;
  final int? index;
  final String? requestId;

  @override
  State<MyRequestProcess> createState() => _MyRequestProcessState();
}

class _MyRequestProcessState extends State<MyRequestProcess> {
  List<DonationModel> donations = [];
  List<String> docId = [];
  int docIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDonationCubit, GetDonationState>(
      listener: (context, state) {
        if (state is GetDonationLodging) {
          donations = [];
        } else if (state is GetDonationSuccess) {
          docId = state.docId;
          for (int i = 0; i < state.donations.length; i++) {
            if (widget.request.donationId == docId[i]) {
              donations.add(state.donations[i]);
              docIndex = i;
            }
          }
        } else if (state is GetDonationFailure) {}
      },
      builder: (context, state) {
        return donations.length > widget.index!
            ? MyRequestComponent(
                donation: donations[widget.index!],
                onTapRequest: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationDetailsPage(
                          donationModel: donations[widget.index!],
                          docId: docId[docIndex],
                        ),
                      ));
                },
              )
            : const SizedBox();
      },
    );
  }
}
