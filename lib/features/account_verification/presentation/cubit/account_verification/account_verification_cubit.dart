// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'account_verification_state.dart';

class AccountVerificationCubit extends Cubit<AccountVerificationState> {
  AccountVerificationCubit() : super(AccountVerificationInitial());
  CollectionReference verificationRequests =
      FirebaseFirestore.instance.collection('verification requests');

  Future<void> sendVerificationRequest(
      {required String image, required String userEmail}) async {
    try {
      await verificationRequests.add({'image': image, 'userEmail': userEmail});
    } catch (e) {
      e.toString();
    }
  }
}
