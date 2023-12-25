import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserDataCubit() : super(UpdateUserDataInitial());
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateNameAndMobileNumber(
      {required String name,
      required String mobileNumber,
      required String docId}) async {
    await users.doc(docId).update({'name': name, 'mobileNumber': mobileNumber});
  }

  Future<void> updateUserImage(
      {required String docId, required String url}) async {
    await users.doc(docId).update({'image': url});
  }
}
