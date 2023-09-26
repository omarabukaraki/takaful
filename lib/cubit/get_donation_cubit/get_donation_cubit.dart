import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:takaful/models/post_model.dart';

part 'get_donation_state.dart';

class GetDonationCubit extends Cubit<GetDonationState> {
  GetDonationCubit() : super(GetDonationInitial());
  CollectionReference posts = FirebaseFirestore.instance.collection('post');
  void getPost() {
    emit(GetDonationLodging());
    try {
      posts.orderBy('createAt', descending: true).snapshots().listen((event) {
        List<PostModel> postList = [];
        for (var doc in event.docs) {
          postList.add(PostModel(
              doc['id'],
              doc['postState'],
              doc['title'],
              doc['image'],
              doc['category'],
              doc['itemOrService'],
              doc['description'],
              doc['location'],
              doc['state'],
              doc['createAt'],
              doc['donarAccount'],
              doc['count']));
        }
        emit(GetDonationSuccess(posts: postList));
      });
    } catch (e) {
      emit(GetDonationFailure());
    }
  }
}
