// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/features/donation_request/presentation/views/widget/my_donation_requests_component.dart';

class MyDonationRequests extends StatelessWidget {
  const MyDonationRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
            button: false, textOne: AppString.textItemRequest, textTwo: ''),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            MyDonationRequestsComponent(
              onTapAccept: () {
                print('Accept');
              },
              onTapReject: () {
                print('Reject');
              },
              title: 'وجبة لشخص صالح لمدة يوم',
              nameUser: 'عمر ابو كركي',
              time: 10,
            ),
          ],
        ));
  }
}
