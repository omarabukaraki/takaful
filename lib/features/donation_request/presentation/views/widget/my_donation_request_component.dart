import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/donation_request/presentation/cubit/edit_donation/edit_donation_cubit.dart';
import '../../../../auth/data/model/user_details_model.dart';
import '../../../../profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import '../../../data/model/request_donation.dart';
import '../../cubit/get_request/get_request_cubit.dart';
import 'my_donation_requests_component.dart';

class MyDonationRequestComponent extends StatefulWidget {
  const MyDonationRequestComponent({
    super.key,
    this.requestId,
    this.index,
    required this.requestList,
    required this.requestIdList,
    required this.requests,
  });
  final List<String> requestIdList;
  final List<RequestDonationModel> requestList;
  final RequestDonationModel requests;
  final int? index;
  final String? requestId;
  @override
  State<MyDonationRequestComponent> createState() =>
      _MyDonationRequestComponentState();
}

class _MyDonationRequestComponentState
    extends State<MyDonationRequestComponent> {
  List<UserDetailsModel> user = [];
  bool isLoading = false;

  RequestDonationModel? requestDonationModel;
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');
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
                isApproved: (widget.requests.isApproved),
                isNotApproved: (!widget.requests.isApproved),
                onTapAccept: () async {
                  requestDonationModel = widget.requests;
                  await BlocProvider.of<EditDonationCubit>(context)
                      .editDonation(donationId: widget.requests.donationId);
                  await BlocProvider.of<GetRequestCubit>(context)
                      .editRequest(requestId: widget.requestId!);
                  for (int i = 0; i < widget.requestList.length; i++) {
                    if (widget.requestList[i].titleDonation ==
                            requestDonationModel!.titleDonation &&
                        widget.requestList[i].isApproved == false) {
                      requests.doc(widget.requestIdList[i]).delete();
                    }
                  }
                },
                onTapReject: () async {
                  try {
                    await BlocProvider.of<GetRequestCubit>(context)
                        .deleteRequest(
                            // donarId: FirebaseAuth.instance.currentUser!.uid,
                            docId: widget.requestId!);
                  } catch (e) {
                    print(e);
                  }
                },
                nameUser:
                    user.length > widget.index! ? user[widget.index!].name : '',
                title: widget.requests.titleDonation,
                time: widget.requests.timeRequest.substring(0, 16),
                image: user.length > widget.index!
                    ? user[widget.index!].image
                    : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f')
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
