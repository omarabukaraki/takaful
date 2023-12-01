import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'my_request_state.dart';

class MyRequestCubit extends Cubit<MyRequestState> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  MyRequestCubit() : super(MyRequestInitial());

  Future<void> createRequest() async {
    users.doc().collection('my_request').add({});
  }
}
