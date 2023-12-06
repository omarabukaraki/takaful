// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';
// import 'package:takaful/features/save_doantion/data/save_donation_model.dart';

// part 'save_donation_state.dart';

// class SaveDonationCubit extends Cubit<SaveDonationState> {
//   SaveDonationCubit() : super(SaveDonationInitial());
//   CollectionReference saveDonation =
//       FirebaseFirestore.instance.collection('save donation');

//   Future<void> addDonationToSave(
//       {required String donationId, required String userId}) async {
//     saveDonation.add({
//       'donationId': donationId,
//       'userId': userId,
//     });
//   }

//   void getSaveDonations() {
//     emit(SaveDonationLoading());
//     List<SaveDonationModel> donationsSave = [];
//     List<String> donationsSaveId = [];
//     saveDonation.snapshots().listen((event) {
//       for (var doc in event.docs) {
//         donationsSave.add(SaveDonationModel.fromJson(doc));
//         donationsSaveId.add(doc.id);
//       }
//       emit(SaveDonationSuccess(
//           donationsSave: donationsSave, donationsSaveId: donationsSaveId));
//     });
//   }

//   Future<void> deleteSaveDonation({required String donationSaveId}) async {
//     await saveDonation.doc(donationSaveId).delete();
//     emit(DeleteSaveDonationSuccess());
//   }
// }
