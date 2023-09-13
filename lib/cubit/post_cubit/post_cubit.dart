import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:takaful/models/post_model.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  CollectionReference posts = FirebaseFirestore.instance.collection('post');
  void addPost({
    required bool postState,
    required String title,
    required String image,
    required String category,
    required String itemOrService,
    required String description,
    required String location,
    required String state,
    required int count,
  }) {
    posts.add({
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
  }

  void getPost() {
    emit(PostLodging());
    try {
      posts.orderBy('createAt', descending: true).snapshots().listen((event) {
        List<PostModel> postList = [];
        for (var doc in event.docs) {
          postList.add(PostModel.fromJson(doc));
        }
        emit(PostSuccess(posts: postList));
      });
    } catch (e) {
      emit(PostFailure());
    }
  }
}
