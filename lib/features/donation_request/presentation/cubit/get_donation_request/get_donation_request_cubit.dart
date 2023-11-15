import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/model/request_donation.dart';

part 'get_donation_request_state.dart';

class GetDonationRequestCubit extends Cubit<GetDonationRequestState> {
  GetDonationRequestCubit() : super(GetDonationRequestInitial());

  CollectionReference requestDonation =
      FirebaseFirestore.instance.collection('request donation');

  void getRequest() {
    emit(GetDonationRequestLoading());
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
        emit(GetDonationRequestSuccess(
            requests: requests, requestId: requestId));
      });
    } catch (e) {
      emit(GetDonationRequestFailure());
    }
  }
}
