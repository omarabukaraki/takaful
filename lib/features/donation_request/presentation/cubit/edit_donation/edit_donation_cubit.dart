import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_donation_state.dart';

class EditDonationCubit extends Cubit<EditDonationState> {
  EditDonationCubit() : super(EditDonationInitial());

  CollectionReference donation =
      FirebaseFirestore.instance.collection('donations');
  bool? isTaken;
  Future<void> editDonation({required String donationId}) async {
    await donation.doc(donationId).update({'isTaken': true});
    isTaken = true;
  }
}
