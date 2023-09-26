// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'add_donation_state.dart';

class AddDonationCubit extends Cubit<AddDonationState> {
  AddDonationCubit() : super(AddDonationInitial());
  CollectionReference posts = FirebaseFirestore.instance.collection('post');

  Future<void> addPost({
    required bool postState,
    required String title,
    required List<String> image,
    required String category,
    required String itemOrService,
    required String description,
    required String location,
    required String state,
    required int count,
  }) async {
    emit(AddDonationLodging());
    try {
      await posts.add({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'postState': true,
        'title': title,
        'image': image,
        'category': category,
        'itemOrService': itemOrService,
        'count': count,
        'description': description,
        'location': location,
        'state': state,
        'createAt': DateTime.now().toString(),
        'donarAccount': FirebaseAuth.instance.currentUser!.email.toString(),
      });
      emit(AddDonationSuccess());
    } catch (e) {
      emit(AddDonationFailure());
    }
  }
}
