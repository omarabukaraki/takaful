import 'package:flutter/material.dart';
import 'package:takaful/component/custom_app_bar.dart';
import 'package:takaful/constant.dart';

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

class NotificationComponent extends StatelessWidget {
  const NotificationComponent({
    super.key,
    this.image,
    this.state,
    this.section,
    this.location,
    this.time,
  });
  final String? image;
  final String? state;
  final String? section;
  final String? location;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 2),
              blurRadius: 5)
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(children: [
        const Expanded(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.more_vert_rounded),
            ],
          ),
        )),
        Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state ?? 'تم  نشر تبرعك بنجاح',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    section ?? 'الاستهلاكيات , الطعام',
                    style: const TextStyle(
                      fontSize: 12,
                      color: kFont,
                    ),
                  ),
                  Text(
                    location ?? 'الموقع في عمان',
                    style: const TextStyle(
                      fontSize: 12,
                      color: kFont,
                    ),
                  ),
                  Text(
                    time ?? 'قبل 3 دقائق',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    image ?? 'assets/image/pizza.png',
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                  )),
            )),
      ]),
    );
  }
}
