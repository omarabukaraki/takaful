import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/donation_request/data/model/request_donation.dart';
import 'package:takaful/features/donation_request/presentation/views/widget/my_donation_requests_component.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/request_donaiton/request_donation_cubit.dart';

class MyDonationRequests extends StatefulWidget {
  const MyDonationRequests({super.key});

  @override
  State<MyDonationRequests> createState() => _MyDonationRequestsState();
}

class _MyDonationRequestsState extends State<MyDonationRequests> {
  List<RequestDonationModel> requests = [];
  List<String> requestId = [];
  bool isLoading = false;
  String userEmail = '';
  // @override
  // void initState() {
  //   BlocProvider.of<RequestDonationCubit>(context).getRequest();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestDonationCubit, RequestDonationState>(
      listener: (context, state) {
        if (state is RequestDonationLoading) {
          isLoading = true;
        } else if (state is RequestDonationSuccess) {
          requests = state.requests;
          requestId = state.requestId;
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
            body: isLoading != true
                ? ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      return const SizedBox();
                      // BlocProvider.of<GetUserDetailsCubit>(context)
                      //     .userDonationInformation(
                      //         email: requests[index].serviceReceiverAccount);
                      // return requests[index].donarAccount ==
                      //         FirebaseAuth.instance.currentUser!.email
                      //     ? NewWidgets(
                      //         requestId: requestId[index],
                      //         requests: requests[index],
                      //         userEmail: requests[index].serviceReceiverAccount,
                      //         index: index,
                      //         length: requests.length,
                      //       )
                      //     : const SizedBox();
                    },
                  )
                : const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class NewWidgets extends StatefulWidget {
  const NewWidgets({
    this.length,
    this.requestId,
    super.key,
    this.index,
    this.userEmail,
    required this.requests,
  });

  final RequestDonationModel requests;
  final String? userEmail;
  final int? index;
  final int? length;
  final String? requestId;
  @override
  State<NewWidgets> createState() => _NewWidgetsState();
}

class _NewWidgetsState extends State<NewWidgets> {
  List<UserDetailsModel> user = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
      listener: (context, state) {
        if (state is GetUserDetailsSuccessForDonation) {
          user.add(state.user);
          print('name: ${user}');
        } else if (state is GetUserDetailsLoadingForDonation) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return MyDonationRequestsComponent(
            onTapReject: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('request donation')
                    .doc(widget.requestId)
                    .delete();
              } catch (e) {}
            },
            nameUser: user.isNotEmpty && widget.index! < user.length
                ? user[widget.index!].name
                : '',
            title: widget.requests.titleDonation,
            time: widget.requests.timeRequest.substring(0, 16),
            image: user.isNotEmpty && widget.index! < user.length
                ? user[widget.index!].image
                : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f');
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