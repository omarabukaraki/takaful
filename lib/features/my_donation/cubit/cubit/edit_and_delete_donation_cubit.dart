import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
part 'edit_and_delete_donation_state.dart';

class EditAndDeleteDonationCubit extends Cubit<EditAndDeleteDonationState> {
  EditAndDeleteDonationCubit() : super(EditAndDeleteDonationInitial());
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  Future<void> editDonationData(
      {required String docId,
      required String title,
      required String typeOfDonation,
      required String state,
      required int count,
      required String description}) async {
    emit(EditDonationLoading());
    try {
      await donations.doc(docId).update({
        'title': title,
        'typeOfDonation': typeOfDonation,
        'state': state,
        'count': count,
        'description': description,
        'postState': true,
      });
      emit(EditDonationSuccess());
    } catch (e) {
      emit(EditDonationFailure());
    }
  }

  Future<void> deleteDonation({required String docId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('donations')
          .doc(docId)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
