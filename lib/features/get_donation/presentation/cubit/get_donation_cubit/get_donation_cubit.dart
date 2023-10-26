import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
part 'get_donation_state.dart';

class GetDonationCubit extends Cubit<GetDonationState> {
  GetDonationCubit() : super(GetDonationInitial());
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');
  void getPost() {
    emit(GetDonationLodging());
    try {
      donations
          .orderBy('createAt', descending: true)
          .snapshots()
          .listen((event) {
        List<DonationModel> donationsList = [];
        // List<String> docId = [];
        for (var doc in event.docs) {
          donationsList.add(DonationModel.fromJson(doc));
          // docId.add(doc.id);
        }
        emit(GetDonationSuccess(donations: donationsList));
      });
    } catch (e) {
      emit(GetDonationFailure());
    }
  }
}
//   void getPostWithFiller(bool filter) {
//     emit(GetDonationLodging());
//     try {
//       if (filter == false) {
//         donations
//             .where('typeOfDonation', isEqualTo: 'معروض')
//             .snapshots()
//             .listen((event) {
//           List<DonationModel> donationsList = [];
//           // List<String> docId = [];
//           for (var doc in event.docs) {
//             donationsList.add(DonationModel.fromJson(doc));
//             // docId.add(doc.id);
//           }
//           emit(GetDonationSuccess(donations: donationsList));
//         });
//       } else {
//         donations
//             .where('typeOfDonation', isEqualTo: 'مطلوب')
//             .snapshots()
//             .listen((event) {
//           List<DonationModel> donationsList = [];
//           // List<String> docId = [];
//           for (var doc in event.docs) {
//             donationsList.add(DonationModel.fromJson(doc));
//             // docId.add(doc.id);
//           }
//           emit(GetDonationSuccess(donations: donationsList));
//         });
//       }
//     } catch (e) {
//       emit(GetDonationFailure());
//     }
//   }
// }
// DonationModel(
//               doc['id'],
//               doc['postState'],
//               doc['title'],
//               doc['image'],
//               doc['category'],
//               doc['itemOrService'],
//               doc['description'],
//               doc['location'],
//               doc['state'],
//               doc['createAt'],
//               doc['donarAccount'],
//               doc['count'])

 