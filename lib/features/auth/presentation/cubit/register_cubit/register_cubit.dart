import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> createUser({
    required String email,
    required String password,
    required String name,
    required String mobileNumber,
  }) async {
    emit(RegisterLodging());
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        emit(RegisterSuccess());
        await users.add({
          'id': FirebaseAuth.instance.currentUser!.uid,
          'name': name,
          'email': email,
          'mobileNumber': mobileNumber,
          'image':
              'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f&_gl=1*1p08skf*_ga*MTU3NDc4MjEzNi4xNjk0MDE3NjE4*_ga_CW55HF8NVT*MTY5NjA3NzM3Mi41Mi4xLjE2OTYwNzc4NzMuNTMuMC4w'
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMassage: 'كلمة المرور ضعيفة للغاية '));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errMassage: 'الحساب موجود بالفعل الرجاء تسجيل دخول'));
      }
    } catch (e) {
      emit(RegisterFailure(errMassage: e.toString()));
    }
  }
}
