import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/donation_details_page.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_component.dart';

class KeepBrowsingPage extends StatefulWidget {
  const KeepBrowsingPage({super.key});

  @override
  State<KeepBrowsingPage> createState() => _KeepBrowsingPageState();
}

class _KeepBrowsingPageState extends State<KeepBrowsingPage> {
  @override
  void initState() {
    BlocProvider.of<GetDonationCubit>(context).getPost(descending: false);
    super.initState();
  }

  List<DonationModel> donations = [];
  List<String> donationId = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textOne: AppString.textKeepBrowsing,
        textTwo: '',
        button: true,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<GetDonationCubit, GetDonationState>(
        listener: (context, state) {
          if (state is GetDonationSuccess) {
            donations = state.donations;
            donationId = state.docId;
          }
        },
        builder: (context, state) {
          return ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) => DonationComponent(
                    donation: donations[index],
                    donationId: donationId[index],
                    onTapRequest: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationDetailsPage(
                                donation: donations[index],
                                docId: donationId[index]),
                          ));
                    },
                  ));
        },
      ),
    );
  }
}
