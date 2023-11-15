import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:takaful/features/donation_request/data/model/request_donation.dart';

part 'request_donation_state.dart';

class RequestDonationCubit extends Cubit<RequestDonationState> {
  RequestDonationCubit() : super(RequestDonationInitial());
  CollectionReference requestDonation =
      FirebaseFirestore.instance.collection('request donation');
  bool? isRequested;
  Future<void> request(
      {required String donationId,
      required String titleDonation,
      required String donarAccount,
      required String serviceReceiveAccount}) async {
    requestDonation.add({
      'donationId': donationId,
      'serviceReceiverId': FirebaseAuth.instance.currentUser!.uid,
      'titleDonation': titleDonation,
      'donarAccount': donarAccount,
      'timeRequest': DateTime.now().toString(),
      'serviceReceiverAccount': serviceReceiveAccount
    });
  }

  void getRequest() {
    emit(RequestDonationLoading());
    try {
      requestDonation
          .orderBy('timeRequest', descending: true)
          .snapshots()
          .listen((event) {
        List<RequestDonationModel> requests = [];
        List<String> requestId = [];
        for (var doc in event.docs) {
          requests.add(RequestDonationModel(
              donationId: doc['donationId'],
              serviceReceiverId: doc['serviceReceiverId'],
              donarAccount: doc['donarAccount'],
              serviceReceiverAccount: doc['serviceReceiverAccount'],
              timeRequest: doc['timeRequest'],
              titleDonation: doc['titleDonation']));
          requestId.add(doc.id);
        }
        emit(RequestDonationSuccess(requests: requests, requestId: requestId));
      });
    } catch (e) {
      emit(RequestDonationFailure());
    }
  }

  Future<void> deleteRequest({required String docId}) async {
    try {
      await requestDonation.doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }

  bool isReq(
      {required String postId,
      required String docId,
      required String userId,
      required String userRid}) {
    print('postId : $postId');
    print(userRid);
    if (postId == docId) {
      if (userId == userRid) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
