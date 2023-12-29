import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/get_request/get_request_cubit.dart';
import 'widget/my_donation_request_component.dart';
import 'package:takaful/features/donation_request/data/model/request_donation.dart';
import '../../../profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';

class MyDonationRequests extends StatefulWidget {
  const MyDonationRequests({super.key});

  @override
  State<MyDonationRequests> createState() => _MyDonationRequestsState();
}

class _MyDonationRequestsState extends State<MyDonationRequests> {
  @override
  void initState() {
    BlocProvider.of<GetRequestCubit>(context).getRequest();
    super.initState();
  }

  List<RequestDonationModel> requests = [];
  List<String> requestId = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
            button: false, textOne: AppString.textItemRequest, textTwo: ''),
        body: BlocConsumer<GetRequestCubit, GetRequestState>(
          listener: (context, state) {
            if (state is GetRequestLoading) {
              isLoading = true;
            } else if (state is GetRequestSuccess) {
              requests = state.requests;
              requestId = state.requestId;
              isLoading = false;
            } else if (state is GetRequestFailure) {
              isLoading = false;
            }
          },
          builder: (context, state) {
            return isLoading != true
                ? SingleChildScrollView(
                    child: Column(children: requestDataList(requests)))
                : const Center(child: CircularProgressIndicator());
          },
        ));
  }

  List<Widget> requestDataList(List<RequestDonationModel> requests) {
    List<Widget> itemList = [];
    for (int i = 0; i < requests.length; i++) {
      itemList.add(myDonationRequest(i));
    }
    return itemList;
  }

  Widget myDonationRequest(int index) {
    //used to get user information by the account from request
    BlocProvider.of<GetUserDetailsCubit>(context)
        .userDonationInformation(email: requests[index].serviceReceiverAccount);
    return requests[index].donarAccount ==
            FirebaseAuth.instance.currentUser!.email
        ?
        //need a refactor code to delete duplicated data
        MyDonationRequestComponent(
            requestIdList: requestId,
            requestList: requests,
            requests: requests[index],
            index: index,
            requestId: requestId[index],
          )
        : const SizedBox();
  }
}
