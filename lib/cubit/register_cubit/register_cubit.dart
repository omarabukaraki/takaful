import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> createUser(
      {required String email, required String password}) async {
    emit(RegisterLodging());
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        emit(RegisterSuccess());
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
