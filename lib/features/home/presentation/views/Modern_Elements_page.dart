import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/donation_details_page.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_component.dart';

class ModernElementsPage extends StatefulWidget {
  const ModernElementsPage({super.key});

  @override
  State<ModernElementsPage> createState() => _ModernElementsPageState();
}

class _ModernElementsPageState extends State<ModernElementsPage> {
  @override
  void initState() {
    BlocProvider.of<GetDonationCubit>(context).getPost();
    super.initState();
  }

  List<DonationModel> donations = [];
  List<String> donationId = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          onTap: () {
            Navigator.pop(context);
          },
          button: true,
          textOne: AppString.textModernElements,
          textTwo: ''),
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
              itemBuilder: (context, index) =>
                  (donations[index].postState == true &&
                          donations[index].isTaken != true)
                      ? DonationComponent(
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
                        )
                      : const SizedBox());
        },
      ),
    );
  }
}
