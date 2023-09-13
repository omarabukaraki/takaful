import 'package:flutter/material.dart';

void showSankBar(BuildContext context, String message,
    {Color color = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      textDirection: TextDirection.rtl,
    ),
    backgroundColor: color,
  ));
}
