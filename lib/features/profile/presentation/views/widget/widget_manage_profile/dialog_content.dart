import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/add_donation/presentation/views/widgets/alert_dialog_button.dart';
import 'package:takaful/features/auth/presentation/views/login_page.dart';
import 'package:takaful/features/profile/presentation/cubit/delete_account/delete_account_cubit.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({super.key, this.docId});
  final String? docId;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          const Text('هل انت متأكد من حذف الحساب', textAlign: TextAlign.center),
      actions: [
        Row(
          children: [
            Expanded(
              child: AlertDialogButton(
                titleButton: 'الغاء',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 10),
            BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
              listener: (context, state) {
                if (state is DeleteAccountSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                  showSankBar(context, 'تم حذف الحساب بنجاح',
                      color: AppColor.kGreen);
                } else if (state is DeleteAccountFailure) {
                  showSankBar(context, state.errMessage);
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: AlertDialogButton(
                    color: AppColor.kRed,
                    titleButton: 'حذف',
                    onTap: () async {
                      await BlocProvider.of<DeleteAccountCubit>(context)
                          .deleteAccount(docId: docId!);
                    },
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
