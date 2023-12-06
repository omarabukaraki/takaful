// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:takaful/core/widgets/custom_app_bar.dart';
// import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
// import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_component.dart';
// import 'package:takaful/features/save_doantion/data/save_donation_model.dart';
// import 'package:takaful/features/save_doantion/presentation/cubit/cubit/save_donation_cubit.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../../get_donation/data/model/donation_model.dart';
// import '../../../get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
// import '../../../get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';
// import '../../../get_donation/presentation/views/widget/image_count.dart';

// class SaveDonationPage extends StatefulWidget {
//   const SaveDonationPage({super.key});

//   @override
//   State<SaveDonationPage> createState() => _SaveDonationPageState();
// }

// class _SaveDonationPageState extends State<SaveDonationPage> {
//   @override
//   void initState() {
//     BlocProvider.of<SaveDonationCubit>(context).getSaveDonations();
//     super.initState();
//   }

//   List<SaveDonationModel> donationsSave = [];
//   List<String> donationSaveId = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//           button: true,
//           onTap: () => Navigator.pop(context),
//           textOne: 'الإعلانات المحفوظة',
//           textTwo: ''),
//       body: BlocConsumer<SaveDonationCubit, SaveDonationState>(
//         listener: (context, state) {
//           if (state is SaveDonationSuccess) {
//             donationsSave = state.donationsSave;
//             donationSaveId = state.donationsSaveId;
//           } else if (state is SaveDonationLoading) {
//             // donationsSave = [];
//           }
//         },
//         builder: (context, state) {
//           return ListView.builder(
//             itemCount: donationsSave.length,
//             itemBuilder: (context, index) => saveDonationItem(index: index),
//           );
//         },
//       ),
//     );
//   }

//   Widget saveDonationItem({required int index}) {
//     BlocProvider.of<GetDonationCubit>(context).getPost();
//     return donationsSave[index].userId == FirebaseAuth.instance.currentUser!.uid
//         ? SaveDonationProcess(donationSave: donationsSave[index])
//         : const SizedBox();
//   }
// }

// class SaveDonationProcess extends StatefulWidget {
//   const SaveDonationProcess({super.key, this.donationSave});
//   final SaveDonationModel? donationSave;
//   @override
//   State<SaveDonationProcess> createState() => _SaveDonationProcessState();
// }

// class _SaveDonationProcessState extends State<SaveDonationProcess> {
//   DonationModel? donation;
//   List<String> donationId = [];
//   bool isLoading = true;
//   String? sDonationId;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GetDonationCubit, GetDonationState>(
//       listener: (context, state) {
//         if (state is GetDonationSuccess) {
//           donationId = state.docId;
//           for (int i = 0; i < state.donations.length; i++) {
//             if (state.docId[i] == widget.donationSave!.donationId) {
//               donation = state.donations[i];
//               sDonationId = state.docId[i];
//             }
//           }
//           isLoading = false;
//         } else if (state is GetDonationLodging) {
//           isLoading = true;
//         } else if (state is GetDonationFailure) {
//           isLoading = false;
//         }
//       },
//       builder: (context, state) {
//         return isLoading != true
//             ? DonationComponent(
//                 donation: donation,
//                 donationId: sDonationId,
//               )
//             : const SizedBox();
//       },
//     );
//   }
// }

// // SaveDonationComponent(
// //                 donation: donation,
// //               )
// class SaveDonationComponent extends StatelessWidget {
//   const SaveDonationComponent(
//       {super.key, this.onTapEdit, this.onTapDelete, this.donation});

//   final DonationModel? donation;
//   final VoidCallback? onTapEdit;
//   final VoidCallback? onTapDelete;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       width: double.infinity,
//       height: 200,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//           Expanded(
//               flex: 5,
//               child: Row(
//                 children: [
//                   //start information donation
//                   Expanded(
//                     flex: 1,
//                     child: DonationCoverInformation(
//                         title: donation!.title,
//                         typePost:
//                             '${donation!.category} - ${donation!.itemOrService}',
//                         location:
//                             '${donation!.location} - ${donation!.subLocation}'),
//                   ),
//                   //end information donation

//                   //start image donation
//                   Expanded(
//                       flex: 1,
//                       child: DonationCoverImage(
//                         image: donation!.image[0],
//                       )),
//                   //end image donation
//                 ],
//               )),
//           //start display image counter
//           Expanded(
//               flex: 1, child: ImageCount(countImage: donation!.image.length)),
//           // donation!.image.length
//           //end display image counter

//           //start buttons delete and edit
//           Expanded(
//               flex: 2,
//               child: Row(
//                 children: [
//                   //start delete button
//                   Expanded(
//                     flex: 1,
//                     child: GestureDetector(
//                       onTap: onTapDelete,
//                       child: Container(
//                         margin: const EdgeInsets.only(top: 5, left: 15),
//                         decoration: BoxDecoration(
//                           color: AppColor.kRed,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                             child: Text(
//                           'الغاء الحفظ',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: AppColor.kWhite,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )),
//                       ),
//                     ),
//                   ),
                  //end delete button

                  //start edit button
                  // Expanded(
                  //   flex: 1,
                  //   child: GestureDetector(
                  //     onTap: onTapEdit,
                  //     child: Container(
                  //       margin: const EdgeInsets.only(top: 5, left: 15),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: AppColor.kPrimary),
                  //       child: const Center(
                  //           child: Text(
                  //         'تعديل',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       )),
                  //     ),
                  //   ),
                  // )
                  // //end edit button
              //   ],
              // ))
          //end buttons delete and edit
//         ]),
//       ),
//     );
//   }
// }

// class SaveDonation extends StatefulWidget {
//   const SaveDonation({
//     super.key,
//     required this.onTapSave,
//     required this.donationId,
//     required this.userId,
//   });
//   final String userId;
//   final String donationId;
//   final VoidCallback? onTapSave;

//   @override
//   State<SaveDonation> createState() => _SaveDonationState();
// }

// class _SaveDonationState extends State<SaveDonation> {
//   @override
//   void initState() {
//     BlocProvider.of<SaveDonationCubit>(context).getSaveDonations();

//     super.initState();
//   }

//   String? donationSaveId;
//   bool checker = false;

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SaveDonationCubit, SaveDonationState>(
//       listener: (context, state) {
//         if (state is SaveDonationSuccess) {
//           for (int i = 0; i < state.donationsSave.length; i++) {
//             if (state.donationsSave[i].donationId == widget.donationId &&
//                 state.donationsSave[i].userId ==
//                     FirebaseAuth.instance.currentUser!.uid) {
//               donationSaveId = state.donationsSaveId[i];
//               checker = true;
//             }
//           }
//         } else if (state is DeleteSaveDonationSuccess) {
//           checker = false;
//         }
//       },
//       builder: (context, state) {
//         return checker != true
//             ? GestureDetector(
//                 onTap: widget.onTapSave,
//                 child: const CustomButtonToDonationComponent(),
//               )
//             : GestureDetector(
//                 onTap: () async {
//                   await BlocProvider.of<SaveDonationCubit>(context)
//                       .deleteSaveDonation(donationSaveId: donationSaveId!);
//                 },
//                 child: const CustomButtonToDonationComponent(
//                   text: 'تم الحفظ',
//                   color: AppColor.kGreen,
//                 ),
//               );
//       },
//     );
//   }
// }

// class CustomButtonToDonationComponent extends StatelessWidget {
//   const CustomButtonToDonationComponent({super.key, this.text, this.color});
//   final String? text;
//   final Color? color;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       margin: const EdgeInsets.only(top: 5, left: 15),
//       decoration: BoxDecoration(
//         border: Border.all(color: color ?? AppColor.kPrimary),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Center(
//           child: Text(
//         text ?? 'حفظ',
//         style: TextStyle(
//           fontSize: 16,
//           color: color ?? AppColor.kPrimary,
//           fontWeight: FontWeight.bold,
//         ),
//       )),
//     );
//   }
// }
