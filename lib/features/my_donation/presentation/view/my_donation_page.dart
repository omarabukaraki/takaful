import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import '../../../get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import '../cubit/cubit/edit_and_delete_donation_cubit.dart';
import 'edit_donation_page.dart';
import 'widget/my_donation_component.dart';

class MyDonationPage extends StatefulWidget {
  const MyDonationPage({super.key});
  static String id = 'MyDonationPage';
  @override
  State<MyDonationPage> createState() => _MyDonationPageState();
}

class _MyDonationPageState extends State<MyDonationPage> {
  List<DonationModel> donation = [];
  List docId = [];

  //start get all donation
  @override
  void initState() {
    BlocProvider.of<GetDonationCubit>(context).getPost();
    super.initState();
  }
  //end  get all donation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          button: true,
          onTap: () => Navigator.pop(context),
          textOne: 'إعلاناتي',
          textTwo: ''),
      body: BlocConsumer<GetDonationCubit, GetDonationState>(
        listener: (context, state) {
          if (state is GetDonationSuccess) {
            donation = state.donations;
            docId = state.docId;
          } else if (state is GetDonationLodging) {
          } else if (state is GetDonationFailure) {}
        },
        builder: (context, state) {
          return ListView.builder(
            itemCount: donation.length,
            itemBuilder: (context, index) {
              //the condition to get just user donation
              return donation[index].id ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? MyDonationComponent(
                      isTaken: donation[index].isTaken,
                      donation: donation[index],
                      onTapDelete: () async {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.warning,
                          body: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'هل انت متأكد من حذف التبرع ؟',
                              ),
                            ),
                          ),
                          btnOkText: 'تراجع',
                          btnCancelText: 'حذف',
                          title: 'This is Ignored',
                          desc: 'This is also Ignored',
                          btnCancelOnPress: () async {
                            await BlocProvider.of<EditAndDeleteDonationCubit>(
                                    context)
                                .deleteDonation(docId: docId[index]);
                          },
                          btnOkColor: AppColor.kPrimary,
                          btnOkOnPress: () {},
                        ).show();
                      },
                      onTapEdit: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditDonationPage(
                                      donation: donation[index],
                                      docId: docId[index],
                                    )));
                      },
                    )
                  : const SizedBox();
            },
          );
        },
      ),
    );
  }
}
