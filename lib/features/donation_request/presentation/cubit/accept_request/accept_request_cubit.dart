// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../data/model/request_donation.dart';

part 'accept_request_state.dart';

class AcceptRequestCubit extends Cubit<AcceptRequestState> {
  AcceptRequestCubit() : super(AcceptRequestInitial());

  CollectionReference donation =
      FirebaseFirestore.instance.collection('donations');
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  Future<void> acceptRequestDonation({
    required String donationId,
    required String requestId,
  }) async {
    await donation.doc(donationId).update({'isTaken': true});
    await requests.doc(requestId).update({'isApproved': true});
  }

  Future<void> deleteRejectedRequest({
    required RequestDonationModel request,
    required List<String> requestIdList,
    required List<RequestDonationModel> requestList,
  }) async {
    for (int i = 0; i < requestList.length; i++) {
      if (requestList[i].titleDonation == request.titleDonation &&
          requestList[i].isApproved == false) {
        await requests.doc(requestIdList[i]).delete();
      }
    }
  }
}
