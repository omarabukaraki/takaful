import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
part 'get_donation_state.dart';

class GetDonationCubit extends Cubit<GetDonationState> {
  GetDonationCubit() : super(GetDonationInitial());
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');
  String typeOfDonation = 'الكل';
  String location = 'كل المدن';
  int currentIndexType = 0;
  int currentIndexLocation = 0;
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

  void getPostWithFiller({required String donation, required String location}) {
    typeOfDonation = donation;
    location = location;
    emit(GetDonationLodging());
    if (donation == 'الكل' && location == 'كل المدن') {
      getPost();
    } else if (donation == 'الكل' && location != 'كل المدن') {
      try {
        donations
            .where('location', isEqualTo: location)
            .snapshots()
            .listen((event) {
          List<DonationModel> donationsList = [];

          for (var doc in event.docs) {
            donationsList.add(DonationModel.fromJson(doc));
          }
          emit(GetDonationSuccess(donations: donationsList));
        });
      } catch (e) {
        emit(GetDonationFailure());
      }
    } else if (donation != 'الكل' && location == 'كل المدن') {
      try {
        donations
            .where('typeOfDonation', isEqualTo: donation)
            .snapshots()
            .listen((event) {
          List<DonationModel> donationsList = [];

          for (var doc in event.docs) {
            donationsList.add(DonationModel.fromJson(doc));
          }
          emit(GetDonationSuccess(donations: donationsList));
        });
      } catch (e) {
        emit(GetDonationFailure());
      }
    } else {
      try {
        donations
            .where('typeOfDonation', isEqualTo: donation)
            .where('location', isEqualTo: location)
            .snapshots()
            .listen((event) {
          List<DonationModel> donationsList = [];

          for (var doc in event.docs) {
            donationsList.add(DonationModel.fromJson(doc));
          }
          emit(GetDonationSuccess(donations: donationsList));
        });
      } catch (e) {
        emit(GetDonationFailure());
      }
    }
  }

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
}
