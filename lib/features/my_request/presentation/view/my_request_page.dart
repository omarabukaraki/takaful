import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/donation_request/data/model/request_donation.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import '../../../donation_request/presentation/cubit/get_request/get_request_cubit.dart';
import 'widget/my_request_process.dart';

class MyRequestPage extends StatefulWidget {
  const MyRequestPage({super.key});

  @override
  State<MyRequestPage> createState() => _MyRequestPageState();
}

class _MyRequestPageState extends State<MyRequestPage> {
  //start get all request to donation
  @override
  void initState() {
    BlocProvider.of<GetRequestCubit>(context).getRequest();
    super.initState();
  }
  //end get all request to donation

  List<RequestDonationModel> requests = [];
  List<String> requestId = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          button: true,
          onTap: () => Navigator.pop(context),
          textOne: 'طلباتي',
          textTwo: ''),
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
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  List<Widget> requestDataList(List<RequestDonationModel> requests) {
    List<Widget> itemList = [];
    for (int i = 0; i < requests.length; i++) {
      itemList.add(myRequest(i));
    }
    return itemList;
  }

  Widget myRequest(int index) {
    BlocProvider.of<GetDonationCubit>(context).getPost();
    return requests[index].serviceReceiverAccount ==
            FirebaseAuth.instance.currentUser!.email
        ? MyRequestProcess(
            request: requests[index],
            index: index,
            requestId: requestId[index],
          )
        : const SizedBox();
  }
}
