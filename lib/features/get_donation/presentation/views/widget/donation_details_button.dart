import 'package:flutter/material.dart';

class DonationDetailsButton extends StatelessWidget {
  const DonationDetailsButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 122, 122, 122),
        radius: 15,
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
