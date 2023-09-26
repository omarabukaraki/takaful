import 'package:flutter/material.dart';

class DonationDetailsInformation extends StatelessWidget {
  const DonationDetailsInformation({
    this.section,
    this.data,
    super.key,
  });
  final String? data;
  final String? section;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6,
            )
          ],
          color: Colors.white),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Text(
              data ?? 'الاستهلاكيات - الطعام',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            )),
        Expanded(
            flex: 1,
            child: Text(
              section ?? 'القسم',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ))
      ]),
    );
  }
}
