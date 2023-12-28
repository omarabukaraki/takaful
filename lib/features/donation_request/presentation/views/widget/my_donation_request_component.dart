import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/donation_request/presentation/cubit/send_notification/send_notification_cubit.dart';
import '../../../../auth/data/model/user_details_model.dart';
import '../../../../profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import '../../../data/model/request_donation.dart';
import '../../cubit/accept_request/accept_request_cubit.dart';
import '../../cubit/get_request/get_request_cubit.dart';
import 'my_donation_requests_component.dart';

class MyDonationRequestComponent extends StatefulWidget {
  const MyDonationRequestComponent({
    super.key,
    required this.requestId,
    required this.index,
    required this.requestList,
    required this.requestIdList,
    required this.requests,
  });
  final List<String> requestIdList;
  final List<RequestDonationModel> requestList;
  final RequestDonationModel requests;
  final int index;
  final String requestId;
  @override
  State<MyDonationRequestComponent> createState() =>
      _MyDonationRequestComponentState();
}

class _MyDonationRequestComponentState
    extends State<MyDonationRequestComponent> {
  List<UserDetailsModel> user = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
      listener: (context, state) {
        if (state is GetUserDetailsSuccessForDonation) {
          user.add(state.user);
          isLoading = false;
        } else if (state is GetUserDetailsLoadingForDonation) {
          isLoading = true;
          user = [];
        }
      },
      builder: (context, state) {
        return isLoading != true
            ? MyDonationRequestsItem(
                isApproved: widget.requests.isApproved,
                onTapAccept: () async {
                  await BlocProvider.of<AcceptRequestCubit>(context)
                      .acceptRequestDonation(
                    donationId: widget.requests.donationId,
                    requestId: widget.requestId,
                  );
                  // ignore: use_build_context_synchronously
                  await BlocProvider.of<SendNotificationCubit>(context)
                      .sendPushNotification(
                    context: context,
                    userId: user[widget.index].id,
                    typeOfNotification: 'ARN',
                    title: 'تم قبول طلبك',
                    body: widget.requests.titleDonation,
                    token: user[widget.index].userToken,
                    donarEmail: FirebaseAuth.instance.currentUser!.email ?? '',
                  );
                  // ignore: use_build_context_synchronously
                  await BlocProvider.of<AcceptRequestCubit>(context)
                      .deleteRejectedRequest(
                          request: widget.requests,
                          requestIdList: widget.requestIdList,
                          requestList: widget.requestList);
                },
                onTapReject: () async {
                  try {
                    await BlocProvider.of<GetRequestCubit>(context)
                        .deleteRequest(docId: widget.requestId);
                  } catch (e) {
                    e.toString();
                  }
                },
                isVerified: user.length > widget.index
                    ? user[widget.index].isVerified
                    : false,
                nameUser:
                    user.length > widget.index ? user[widget.index].name : '',
                title: widget.requests.titleDonation,
                time: widget.requests.timeRequest.substring(0, 16),
                image: user.length > widget.index
                    ? user[widget.index].image
                    : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f')
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
