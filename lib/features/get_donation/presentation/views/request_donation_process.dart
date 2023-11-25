import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import '../../../donation_request/data/model/request_donation.dart';
import '../../../donation_request/presentation/cubit/get_request_from_user/get_request_from_user_cubit.dart';
import '../../data/model/donation_model.dart';
import '../cubit/request_donation/request_donation_cubit.dart';
import 'helper/custom_alert_Dialog.dart';
import 'widget/donation_details_widget/request_button.dart';

class RequestDonationProcess extends StatefulWidget {
  const RequestDonationProcess({super.key, this.donationModel, this.docId});
  final String? docId;
  final DonationModel? donationModel;

  @override
  State<RequestDonationProcess> createState() => _RequestDonationProcessState();
}

class _RequestDonationProcessState extends State<RequestDonationProcess> {
  @override
  void initState() {
    BlocProvider.of<GetRequestFromUserCubit>(context)
        .getRequestFromUser(donarId: widget.donationModel!.id);
    super.initState();
  }

  RequestDonationModel? request;
  String? requestId;
  bool checker = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetRequestFromUserCubit, GetRequestFromUserState>(
      builder: (context, state) {
        return (checker)
            ? RequestButton(
                color: AppColor.kGreen,
                nameButton: AppString.textCancelRequest,
                onTap: () async {
                  checker = false;
                  customAlertDialogCancelRequest(
                          donarId: widget.donationModel!.id,
                          requestId: requestId!,
                          context)
                      .show();
                },
              )
            : RequestButton(
                onTap: () async {
                  customAlertDialogRequest(context).show();
                  await BlocProvider.of<RequestDonationCubit>(context)
                      .requestThePost(
                          donarId: widget.donationModel!.id.toString(),
                          donationId: widget.docId.toString(),
                          titleDonation: widget.donationModel!.title,
                          donarAccount: widget.donationModel!.donarAccount,
                          serviceReceiveAccount: FirebaseAuth
                              .instance.currentUser!.email
                              .toString());
                },
              );
      },
      listener: (context, state) {
        if (state is GetRequestFromUserSuccess) {
          for (int i = 0; i < state.requests.length; i++) {
            if (state.requests[i].donationId == widget.docId &&
                state.requests[i].serviceReceiverAccount ==
                    FirebaseAuth.instance.currentUser!.email) {
              request = state.requests[i];
              requestId = state.requestId[i];
              checker = true;
            } else {}
          }
        }
      },
    );
  }
}
