import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            user.add(UserDetailsModel.fromJson(doc));
            docId = doc.id;
            emit(GetUserDetailsSuccess(user: user));
          }
        }
      });
    } catch (e) {
      emit(GetUserDetailsFailure());
    }
  }

  UserDetailsModel? userForPhone;
  void userDonationInformation({required String email}) async {
    emit(GetUserDetailsLoadingForDonation());

    try {
      users.snapshots().listen((event) {
        UserDetailsModel user;
        for (var doc in event.docs) {
          if (doc['email'] == email) {
            user = UserDetailsModel.fromJson(doc);
            userForPhone = user;
            emit(GetUserDetailsSuccessForDonation(user: user));
          }
        }
      });
    } catch (e) {
      emit(GetUserDetailsFailure());
    }
  }
}


// UserDetailsModel(
//               name: doc['name'],
//               email: doc['email'],
//               image: doc['image'],
//               mobileNumber: doc['mobileNumber'],
//             )