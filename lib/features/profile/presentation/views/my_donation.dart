import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_component.dart';

class MyDonationPage extends StatefulWidget {
  const MyDonationPage({super.key});
  static String id = 'MyDonationPage';
  @override
  State<MyDonationPage> createState() => _MyDonationPageState();
}

class _MyDonationPageState extends State<MyDonationPage> {
  List<DonationModel> donation = [];
  @override
  void initState() {
    BlocProvider.of<GetDonationCubit>(context).getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(button: false, textOne: 'تبرعاتي', textTwo: ''),
      body: BlocConsumer<GetDonationCubit, GetDonationState>(
        listener: (context, state) {
          if (state is GetDonationSuccess) {
            donation = state.donations;
          }
        },
        builder: (context, state) {
          return ListView.builder(
            itemCount: donation.length,
            itemBuilder: (context, index) {
              return donation[index].id ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? DonationComponent(donation: donation[index])
                  : const SizedBox();
            },
          );
        },
      ),
    );
  }
}
