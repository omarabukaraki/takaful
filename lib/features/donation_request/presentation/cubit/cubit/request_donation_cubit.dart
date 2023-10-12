import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:takaful/features/donation_request/data/model/request_donation.dart';

part 'request_donation_state.dart';

class RequestDonationCubit extends Cubit<RequestDonationState> {
  RequestDonationCubit() : super(RequestDonationInitial());
  CollectionReference requestDonation =
      FirebaseFirestore.instance.collection('request donation');
  Future<void> request(
      {
      // required String postId,
      required String titleDonation,
      required String donarAccount,
      required String serviceReceiveAccount}) async {
    requestDonation.add({
      // 'postId': postId,
      'serviceReceiverId': FirebaseAuth.instance.currentUser!.uid,
      'titleDonation': titleDonation,
      'donarAccount': donarAccount,
      'timeRequest': DateTime.now().minute,
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
              // serviceReceiverId: doc['serviceReceiverId'],
              donarAccount: doc['donarAccount'],
              serviceReceiverAccount: doc['serviceReceiverAccount'],
              timeRequest: doc['timeRequest'].toString(),
              titleDonation: doc['titleDonation']));
          requestId.add(doc.id);
        }
        emit(RequestDonationSuccess(requests: requests, requestId: requestId));
      });
    } catch (e) {
      emit(RequestDonationFailure());
    }
  }

  void deleteRequest() {}
}
