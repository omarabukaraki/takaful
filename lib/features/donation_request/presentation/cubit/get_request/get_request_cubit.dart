// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/model/request_donation.dart';
part 'get_request_state.dart';

class GetRequestCubit extends Cubit<GetRequestState> {
  GetRequestCubit() : super(GetRequestInitial());
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  void getRequest() {
    emit(GetRequestLoading());
    try {
      requests
          .orderBy('timeRequest', descending: true)
          .snapshots()
          .listen((event) {
        List<RequestDonationModel> requests = [];
        List<String> requestId = [];
        for (var doc in event.docs) {
          requests.add(RequestDonationModel.fromJson(doc));
          requestId.add(doc.id);
        }
        emit(GetRequestSuccess(requests: requests, requestId: requestId));
      });
    } catch (e) {
      emit(GetRequestFailure());
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> editRequest({required String requestId}) async {
    await requests.doc(requestId).update({'isApproved': true});
  }

  Future<void> deleteRequest({required String docId}) async {
    try {
      await requests.doc(docId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
