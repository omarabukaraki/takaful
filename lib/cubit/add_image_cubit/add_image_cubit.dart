import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_image_state.dart';

class AddImageCubit extends Cubit<AddImageState> {
  AddImageCubit() : super(AddImageInitial());
  List<File> image = [];
  final imagePicker = ImagePicker();
  List<String> nameImage = [];
  List<String> url = [];

  Future pickMultiImageFromGallery() async {
    try {
      var pickedImage = await imagePicker.pickMultiImage();
      for (int i = 0; i < pickedImage.length; i++) {
        image.add(File(pickedImage[i].path));
        nameImage.add(basename(pickedImage[i].path));
      }
      if (image.isEmpty) {
        emit(AddImageFailure(errMessage: 'select image please'));
      } else {
        emit(AddImageSuccess(image: image));
      }
    } catch (e) {
      emit(AddImageFailure(errMessage: e.toString()));
    }
  }

  Future uploadImage() async {
    emit(UploadImageLodging());
    try {
      for (int i = 0; i < image.length; i++) {
        var refStorage = FirebaseStorage.instance.ref('images/${nameImage[i]}');
        await refStorage.putFile(image[i]);
        url.add(await refStorage.getDownloadURL());
      }
      image = [];
      emit(UploadImageSuccess(url: url));
    } catch (e) {
      emit(UploadImageFailure(errMessage: e.toString()));
    }
  }
}
