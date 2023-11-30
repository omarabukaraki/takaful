// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/model/request_donation.dart';
part 'get_request_from_user_state.dart';

class GetRequestFromUserCubit extends Cubit<GetRequestFromUserState> {
  GetRequestFromUserCubit() : super(GetRequestFromUserInitial());
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void getRequestFromUser({required String donarId}) {
    emit(GetRequestFromUserLoading());
    try {
      users
          .doc(donarId)
          .collection('request_donation')
          .orderBy('timeRequest', descending: true)
          .snapshots()
          .listen((event) {
        List<RequestDonationModel> requests = [];
        List<String> requestId = [];

        for (var doc in event.docs) {
          requests.add(RequestDonationModel.fromJson(doc));
          requestId.add(doc.id);
        }

        emit(GetRequestFromUserSuccess(
            requests: requests, requestId: requestId));
      });
    } catch (e) {
      emit(GetRequestFromUserFailure());
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> deleteRequest(
      {required String donarId, required String docId}) async {
    try {
      await users
          .doc(donarId)
          .collection('request_donation')
          .doc(docId)
          .delete();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
