import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/donation_request/data/model/request_donation.dart';
import 'package:takaful/features/donation_request/presentation/cubit/cubit/request_donation_cubit.dart';

class MyDonationRequests extends StatefulWidget {
  const MyDonationRequests({super.key});

  @override
  State<MyDonationRequests> createState() => _MyDonationRequestsState();
}

class _MyDonationRequestsState extends State<MyDonationRequests> {
  List<RequestDonationModel> requests = [];
  List<UserDetailsModel> user = [];
  List<String> requestId = [];
  bool isLoading = false;
  @override
  void initState() {
    BlocProvider.of<RequestDonationCubit>(context).getRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestDonationCubit, RequestDonationState>(
      listener: (context, state) {
        if (state is RequestDonationLoading) {
          isLoading = true;
        } else if (state is RequestDonationSuccess) {
          requests = state.requests;
          // requestId = state.requestId;
          // for (int i = 0; i < requests.length; i++) {
          //   // BlocProvider.of<GetUserDetailsCubit>(context)
          //   //     .userDonationInformation(
          //   //         email: requests[i].serviceReceiverAccount);
          // }
          isLoading = false;
        } else if (state is RequestDonationFailure) {
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: const CustomAppBar(
                button: false, textOne: AppString.textItemRequest, textTwo: ''),
            backgroundColor: Colors.white,
            body: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  width: double.infinity,
                  height: 100,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                      child: Text(
                    requests[index].titleDonation,
                    style: const TextStyle(fontSize: 24),
                  )),
                );
              },
            ));
      },
    );
  }
}
// BlocConsumer<RequestDonationCubit, RequestDonationState>(
//           listener: (context, state) {
//             if (state is RequestDonationLoading) {
//             } else if (state is RequestDonationSuccess) {
//               requests = state.requests;
//               requestId = state.requestId;
//               for (int i = 0; i < requests.length; i++) {
//                 BlocProvider.of<GetUserDetailsCubit>(context)
//                     .userDonationInformation(
//                         email: requests[i].serviceReceiverAccount);
//               }
//             } else if (state is RequestDonationFailure) {}
//           },
//           builder: (context, state) {
//             return BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
//               listener: (context, state) {
//                 if (state is GetUserDetailsSuccessForDonation) {
//                   user.add(state.user);
//                   if (user.length == requests.length) {
//                     isLoading = false;
//                   }
//                 } else if (state is GetUserDetailsLoadingForDonation) {
//                   isLoading = false;
//                 } else if (state is GetUserDetailsFailure) {
//                   isLoading = false;
//                 }
//               },
//               builder: (context, state) {
//                 return isLoading != true
//                     ? ListView.builder(
//                         itemCount: requests.length,
//                         itemBuilder: (context, index) {
//                           return requests[index].donarAccount ==
//                                   FirebaseAuth.instance.currentUser!.email
//                               ? MyDonationRequestsComponent(
//                                   onTapReject: () async {
//                                     try {
//                                       await FirebaseFirestore.instance
//                                           .collection('request donation')
//                                           .doc(requestId[index])
//                                           .delete();
//                                     } catch (e) {}
//                                   },
//                                   title: requests[index].titleDonation,
//                                   image: user.isNotEmpty
//                                       ? user[index].image
//                                       : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f',
//                                   nameUser:
//                                       user.isNotEmpty ? user[index].name : '',
//                                   // time:
//                                   //     '${((DateTime.now().minute - int.parse(requests[index].timeRequest)).toString())} دقيقة ')
//                                 )
//                               : const SizedBox();
//                         },
//                       )
//                     : const Center(
//                         child: CircularProgressIndicator(),
//                       );
//               },
//             );
//           },
//         )
// class NewWidget extends StatefulWidget {
//   NewWidget({
//     super.key,
//     required this.index,
//     required this.requests,
//   });

//   final RequestDonationModel requests;
//   final int index;

//   @override
//   State<NewWidget> createState() => _NewWidgetState();
// }

// class _NewWidgetState extends State<NewWidget> {
//   bool isLoading = false;
//   List<UserDetailsModel> user = [];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
//       listener: (context, state) {
//         if (state is GetUserDetailsSuccessForDonation) {
//           if (widget.requests.serviceReceiverAccount == state.user.email) {
//             user.add(state.user);
//             print('omar ');
//             print(
//                 '---------------------------------------------------------------');
//           } else {
//             print('omar two');
//             print('else ${state.user}');
//           }
//           // print(user);

//           // isLoading = false;
//           // users.insert(widget.index, state.user);
//           // print('users[${widget.index}] : ${users[widget.index].email}');
//         } else if (state is GetUserDetailsLoadingForDonation) {
//           isLoading = true;
//         } else if (state is GetUserDetailsFailure) {
//           isLoading = false;
//         }
//       },
//       builder: (context, state) {
//         return MyDonationRequestsComponent(
//             title: widget.requests.titleDonation,
//             nameUser: 'omar abu karaki',
//             time: 10,
//             image:
//                 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f');
//       },
//     );
//   }
// }
// users.isNotEmpty
//             ? MyDonationRequestsComponent(
//                 image: users.isNotEmpty
//                     ? users[widget.index].image
//                     : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f',
//                 onTapAccept: () {
//                   print(users[widget.index].image);
//                 },
//                 onTapReject: () {
//                   print('Reject');
//                 },
//                 title: widget.requests.titleDonation,
//                 nameUser: users.isNotEmpty ? users[widget.index].name : 'omar ',
//                 time: 10,
//               )
//             :