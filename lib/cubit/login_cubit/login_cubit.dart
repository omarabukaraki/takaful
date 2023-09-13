import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> sginIn(
      {required String emailAddress, required String password}) async {
    emit(LoginLodging());
    await Future.delayed(Duration(seconds: 2));
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errMessage: 'الرجاء تأكيد الحساب'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(
            errMessage: 'لم يتم العثور على مستخدم لهذا البريد الإلكتروني.'));
        // ignore: use_build_context_synchronously
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'كلمة المرور خاطئة'));
      }
    }
  }
}
