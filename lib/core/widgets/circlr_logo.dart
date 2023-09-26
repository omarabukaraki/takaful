import 'package:flutter/material.dart';
import 'package:takaful/core/utils/app_colors.dart';

class CircleLogo extends StatelessWidget {
  const CircleLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 102,
      backgroundColor: AppColor.kPrimary,
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.white,
        child: Expanded(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 70,
            // backgroundImage: AssetImage(
            //   'assets/image/Group 8207.png',
            // ),
            child: Column(
              children: [
                Text(
                  'تكافل',
                  style: TextStyle(
                      fontSize: 51,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3A44A0),
                      fontFamily: 'ElMessiri'),
                ),
                Text(
                  'Takaful',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3A44A0),
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
