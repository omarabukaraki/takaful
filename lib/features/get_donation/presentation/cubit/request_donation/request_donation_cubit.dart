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

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  Future<void> requestDonation(
      {required String donarId,
      required String donationId,
      required String titleDonation,
      required String donarAccount,
      required String serviceReceiveAccount}) async {
    await requests.add({
      'donationId': donationId,
      'serviceReceiverId': FirebaseAuth.instance.currentUser!.uid,
      'titleDonation': titleDonation,
      'donarAccount': donarAccount,
      'timeRequest': DateTime.now().toString(),
      'serviceReceiverAccount': serviceReceiveAccount,
      'isApproved': false,
    });
  }
}
