// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'request_donation_state.dart';

class RequestDonationCubit extends Cubit<RequestDonationState> {
  RequestDonationCubit() : super(RequestDonationInitial());

  CollectionReference donation = FirebaseFirestore.instance.collection('users');

  Future<void> requestThePost(
      {required String donarId,
      required String donationId,
      required String titleDonation,
      required String donarAccount,
      required String serviceReceiveAccount}) async {
    try {
      await donation.doc(donarId).collection('request_donation').add({
        'donationId': donationId,
        'serviceReceiverId': FirebaseAuth.instance.currentUser!.uid,
        'titleDonation': titleDonation,
        'donarAccount': donarAccount,
        'timeRequest': DateTime.now().toString(),
        'serviceReceiverAccount': serviceReceiveAccount
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
