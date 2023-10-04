import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> deleteAccount({required String docId, required}) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.signOut();
      await users.doc(docId).delete();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(DeleteAccountFailure(errMessage: e.toString()));
    }
  }
}
