import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';

part 'get_user_details_state.dart';

class GetUserDetailsCubit extends Cubit<GetUserDetailsState> {
  GetUserDetailsCubit() : super(GetUserDetailsInitial());
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference posts = FirebaseFirestore.instance.collection('post');
  String? docId;

  void getUserDetails() {
    emit(GetUserDetailsLoading());
    try {
      users.snapshots().listen((event) {
        List<UserDetailsModel> user = [];
        for (var doc in event.docs) {
          if (doc['email'] == FirebaseAuth.instance.currentUser!.email) {
            user.add(UserDetailsModel(
              name: doc['name'],
              email: doc['email'],
              image: doc['image'],
              mobileNumber: doc['mobileNumber'],
            ));
            docId = doc.id;
            emit(GetUserDetailsSuccess(user: user));
          }
        }
      });
    } catch (e) {
      emit(GetUserDetailsFailure());
    }
  }

  void userDonationInformation({required String email}) async {
    emit(GetUserDetailsLoadingForDonation());
    UserDetailsModel user;
    try {
      users.snapshots().listen((event) {
        for (var doc in event.docs) {
          if (doc['email'] == email) {
            user = UserDetailsModel(
              name: doc['name'],
              email: doc['email'],
              image: doc['image'],
              mobileNumber: doc['mobileNumber'],
            );
            emit(GetUserDetailsSuccessForDonation(user: user));
          }
        }
      });
    } catch (e) {
      emit(GetUserDetailsFailure());
    }
  }
}
