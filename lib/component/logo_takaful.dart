import 'package:flutter/material.dart';
import 'package:takaful/constant.dart';

class LogoTakaful extends StatelessWidget {
  const LogoTakaful({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        Text('تكافل', style: TextStyle(fontSize: 51, color: kPrimary)),
        Text('Takaful',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: kPrimary)),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAveLogo(image: 'assets/image/foodlogin.png'),
              CircleAveLogo(
                  image: 'assets/image/clotherss.png', color: Colors.white),
              CircleAveLogo(image: 'assets/image/sofa.png'),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

class CircleAveLogo extends StatelessWidget {
  const CircleAveLogo({
    this.color,
    required this.image,
    super.key,
  });
  final String image;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kPrimary,
      radius: 27,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: color ?? kPrimary,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
