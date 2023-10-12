import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:takaful/features/profile/presentation/views/widget/widget_manage_profile/dialog_content.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // CollectionReference requestDonation =
  //     FirebaseFirestore.instance.collection('request donation');
  // CollectionReference post = FirebaseFirestore.instance.collection('donations');
  Future<dynamic> confirmationDialog(BuildContext context,
      {required String docId}) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return DialogContent(docId: docId);
      },
    );
  }

  Future<void> deleteAccount({required String docId}) async {
    try {
      // await requestDonation.doc().delete();
      // await post.doc().delete();
      try {
        await users.doc(docId).delete();
      } catch (e) {}
      await FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.signOut();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(DeleteAccountFailure(errMessage: e.toString()));
    }
  }

  // Future<void> deleteUserDonation() async {
  //   try {
  //     post.snapshots().listen((event) async {
  //       for (var doc in event.docs) {
  //         if (FirebaseAuth.instance.currentUser!.email == null) {
  //           // if (doc['donarAccount'] == FirebaseAuth.instance.currentUser!.email) {
  //           await post.doc(doc.id).delete();
  //           print('deleted : ${doc.id}');

  //           emit(DeleteAccountSuccess());
  //         } else {
  //           print('notDeleted : ${doc.id}');
  //         }
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
