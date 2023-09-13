// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/view/navigator_bar_pages/item_request_page/item_request_component.dart';

class ItemRequest extends StatelessWidget {
  const ItemRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
            button: false, textOne: 'طلبات تبرعاتي', textTwo: ''),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            ItemRequestComponent(
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
