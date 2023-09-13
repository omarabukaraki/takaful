import 'package:flutter/material.dart';
import 'package:takaful/constant.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Text("انشاء حساب",
              style: TextStyle(fontSize: 14, color: kPrimary)),
        ),
        const Text('ليس لديك حساب؟',
            style: TextStyle(color: Color(0xff7c7d7e))),
      ],
    );
  }
}
