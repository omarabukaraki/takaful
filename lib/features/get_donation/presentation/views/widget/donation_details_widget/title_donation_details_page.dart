import 'package:flutter/material.dart';

class TitleDonationDetailsPage extends StatelessWidget {
  const TitleDonationDetailsPage({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text ?? 'الوصف',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    );
  }
}
