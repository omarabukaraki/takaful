import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/donation_request/data/model/request_donation.dart';
import 'package:takaful/features/donation_request/presentation/cubit/get_donation_request/get_donation_request_cubit.dart';

class MyRequestPage extends StatefulWidget {
  const MyRequestPage({super.key});

  @override
  State<MyRequestPage> createState() => _MyRequestPageState();
}

class _MyRequestPageState extends State<MyRequestPage> {
  List<RequestDonationModel> request = [];
  // List<DonationModel> donations = [];
  @override
  void initState() {
    // BlocProvider.of<GetDonationRequestCubit>(context).getRequest();
    // BlocProvider.of<GetDonationCubit>(context).getPost();
    super.initState();
  }

  // void checker() {
  //   List<String> donationId = BlocProvider.of<GetDonationCubit>(context).docId;
  //   var set = Set.of(request);
  //   print(set.containsAll(donationId));
  // }
  // void dd() {
  //   BlocProvider.of<GetDonationRequestCubit>(context).donationList = [];
  //   for (int i = 0; i < request.length; i++) {
  //     BlocProvider.of<GetDonationRequestCubit>(context)
  //         .getPostById(donationId: request[i].donationId);
  //     print('i : ${i}}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          button: true,
          onTap: () => Navigator.pop(context),
          textOne: 'طلباتي',
          textTwo: ''),
      body: BlocConsumer<GetDonationRequestCubit, GetDonationRequestState>(
        listener: (context, state) {
          if (state is GetDonationRequestSuccess) {
            request = state.requests;
            // .where((element) => BlocProvider.of<GetDonationCubit>(context)
            //     .docId
            //     .contains(element.donationId))
            // .toList();
          } else if (state is GetDonationRequestLoading) {
          } else if (state is GetDonationRequestFailure) {}
          // else if (state is GetPostSuccess) {
          //   donations = state.donationList;
          // }
        },
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    // dd();
                    // checker();
                  },
                  child: const Text('get request ')),
              Expanded(
                child: ListView.builder(
                    itemCount: request.length,
                    itemBuilder: (context, index) => Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 2))
                              ]),
                          margin: const EdgeInsets.all(16),
                          child: Center(
                              child: Text(
                            request[index].titleDonation,
                            style: const TextStyle(fontSize: 24),
                          )),
                        )),
              ),
            ],
          );
        },
      ),
    );
  }
}
// context
//                         .read<GetDonationRequestCubit>()
//                         .donationList

//  MyDonationComponent(
//                             donation: BlocProvider.of<GetDonationCubit>(context)
//                                 .donationsList[index])