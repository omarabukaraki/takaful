import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../donation_request/presentation/cubit/get_request_from_user/get_request_from_user_cubit.dart';

AwesomeDialog customAlertDialogCancelRequest(BuildContext context,
    {required String donarId, required String requestId}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.warning,
    body: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'هل انت متأكد من الغاء الطلب ؟',
        ),
      ),
    ),
    btnOkText: 'تراجع',
    btnCancelText: 'الغاء',
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnCancelOnPress: () async {
      await BlocProvider.of<GetRequestFromUserCubit>(context)
          .deleteRequest(donarId: donarId, docId: requestId);
    },
    btnOkOnPress: () {},
  );
}

AwesomeDialog customAlertDialogRequest(BuildContext context) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.success,
    body: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'لقد تم ارسال طلبك بنجاح الرجاء الانتظار',
        ),
      ),
    ),
    btnOkText: 'تم',
    title: '',
    desc: '',
    btnOkOnPress: () {},
  );
}
