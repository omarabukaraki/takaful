import 'package:flutter/material.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/features/notification/presentation/views/widget/notification_component.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  static String id = 'NotificationPage';
  static List<String> notification = [
    'assets/image/ui.png',
    'لم يتم نشر تبرعك بنجاح',
    'الاستهلاكيات , الطعام',
    'الموقع في معان',
    'قبل 5 دقائق'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        button: true,
        textOne: 'الاشعارات',
        textTwo: '',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      body: ListView(children: [
        NotificationComponent(
            image: notification[0],
            state: notification[1],
            section: notification[2],
            location: notification[3],
            time: notification[4]),
        const NotificationComponent()
      ]),
    );
  }
}
