import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void getPost({bool descending = true}) {
    emit(GetDonationLodging());
    try {
      donations
          .orderBy('createAt', descending: descending)
          .snapshots()
          .listen((event) {
        List<DonationModel> donationsList = [];
        List<String> docId = [];
        for (var doc in event.docs) {
          donationsList.add(DonationModel.fromJson(doc));
          docId.add(doc.id);
        }
        emit(GetDonationSuccess(donations: donationsList, docId: docId));
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
          List<String> docId = [];
          for (var doc in event.docs) {
            donationsList.add(DonationModel.fromJson(doc));
            docId.add(doc.id);
          }
          emit(GetDonationSuccess(donations: donationsList, docId: docId));
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
          List<String> docId = [];
          for (var doc in event.docs) {
            donationsList.add(DonationModel.fromJson(doc));
            docId.add(doc.id);
          }
          emit(GetDonationSuccess(donations: donationsList, docId: docId));
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
          List<String> docId = [];
          for (var doc in event.docs) {
            donationsList.add(DonationModel.fromJson(doc));
            docId.add(doc.id);
          }
          emit(GetDonationSuccess(donations: donationsList, docId: docId));
          // emit(GetDonationSuccess(donations: donationsList));
        });
      } catch (e) {
        emit(GetDonationFailure());
      }
    }
  }

  void getDonationBySearch({required String searchName}) {
    FirebaseFirestore.instance
        .collection('donations')
        .orderBy('title')
        .startAt([searchName])
        .endAt(["$searchName\uf8ff"])
        .snapshots()
        .listen((event) {
          List<DonationModel> donation = [];
          List<String> donationId = [];
          for (var doc in event.docs) {
            donation.add(DonationModel.fromJson(doc));
            donationId.add(doc.id);
          }
          emit(GetDonationSuccess(donations: donation, docId: donationId));
        });
  }
}
