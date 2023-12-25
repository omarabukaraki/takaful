import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_image_to_verification_account_state.dart';

class AddImageToVerificationAccountCubit
    extends Cubit<AddImageToVerificationAccountState> {
  AddImageToVerificationAccountCubit()
      : super(AddImageToVerificationAccountInitial());

  final imagePicker = ImagePicker();

  Future pickImageFromGallery() async {
    try {
      var pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      File image;
      String nameImage;
      image = File(pickedImage.path);
      nameImage = basename(pickedImage.path);

      try {
        String url;
        var refStorage =
            FirebaseStorage.instance.ref('verification images/$nameImage');
        emit(AddImageToVerificationAccountLoading());
        await refStorage.putFile(image);
        url = await refStorage.getDownloadURL();
        emit(AddImageToVerificationAccountSuccess(url: url));
      } catch (e) {
        emit(AddImageToVerificationAccountFailure());
      }
    } catch (e) {
      emit(AddImageToVerificationAccountFailure());
    }
  }
}
