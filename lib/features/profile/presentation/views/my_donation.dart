import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/image_count.dart';

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
                  ? MyDonationComponent(
                      donation: donation[index],
                      // onTapEdit: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => DonationDetailsPage(
                      //                 postModel: donation[index],
                      //               )));
                      // },
                    )
                  : const SizedBox();
            },
          );
        },
      ),
    );
  }
}

class MyDonationComponent extends StatelessWidget {
  const MyDonationComponent(
      {super.key, this.onTapEdit, this.onTapDelete, this.donation});
  final DonationModel? donation;

  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DonationCoverInformation(
                        title: donation!.title,
                        typePost:
                            '${donation!.category} - ${donation!.itemOrService}',
                        location: donation!.location),
                  ),
                  Expanded(
                      flex: 1,
                      child: DonationCoverImage(
                        image: donation!.image[0],
                      )),
                ],
              )),
          Expanded(
              flex: 1, child: ImageCount(countImage: donation!.image.length)),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapDelete,
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                          color: AppColor.kRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          'حذف',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapEdit,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.kGreen),
                        child: const Center(
                            child: Text(
                          'تعديل',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
