import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_images_state.dart';

class AddImagesCubit extends Cubit<AddImagesState> {
  AddImagesCubit() : super(AddImagesInitial());

  final imagePicker = ImagePicker();
  List<File> image = [];
  List<String> nameImage = [];
  List<String> url = [];

  Future pickImageFromGallery({required int index}) async {
    try {
      var pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      image.insert(index, File(pickedImage.path));
      nameImage.insert(index, basename(pickedImage.path));
      print("nameImage : $nameImage");
      if (image.isEmpty) {
        emit(AddImagesFailure(errMessage: 'is empty! you should select image'));
      } else {
        emit(AddImagesSuccess(image: image));
      }
      emit(UploadImagesLoading());
      try {
        var refStorage =
            FirebaseStorage.instance.ref('images/${nameImage[index]}');
        await refStorage.putFile(image[index]);
        url.insert(index, await refStorage.getDownloadURL());
        emit(UploadImagesSuccess(url: url));
      } catch (e) {
        emit(UploadImagesFailure(errMessage: e.toString()));
      }
    } catch (e) {
      emit(AddImagesFailure(errMessage: e.toString()));
    }
  }

  Future pickImageFromCamera({required int index}) async {
    try {
      var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;
      image.insert(index, File(pickedImage.path));
      nameImage.insert(index, basename(pickedImage.path));
      if (image.isEmpty) {
        emit(AddImagesFailure(errMessage: 'is empty! you should select image'));
      } else {
        emit(AddImagesSuccess(image: image));
      }
      try {
        var refStorage =
            FirebaseStorage.instance.ref('images/${nameImage[index]}');
        await refStorage.putFile(image[index]);
        url.insert(index, await refStorage.getDownloadURL());
        emit(UploadImagesSuccess(url: url));
      } catch (e) {
        emit(UploadImagesFailure(errMessage: e.toString()));
      }
    } catch (e) {
      emit(AddImagesFailure(errMessage: e.toString()));
    }
  }
}
