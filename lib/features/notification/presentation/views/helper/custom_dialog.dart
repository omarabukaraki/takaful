import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

AwesomeDialog customDialog(BuildContext context, String userMobileNumber) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'هل انت متأكد من اجراء مكالمة مع صاحب الرقم  '
          '$userMobileNumber'
          ' ؟ ',
          textAlign: TextAlign.center,
        ),
      ),
    ),
    btnOkColor: AppColor.kPrimary,
    btnOkText: 'اتصال',
    btnCancelText: 'تراجع',
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnCancelOnPress: () {},
    btnOkOnPress: () async {
      await launchUrlString('tel:$userMobileNumber');
    },
  );
}
