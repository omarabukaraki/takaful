part of 'add_images_cubit.dart';

abstract class AddImagesState {}

class AddImagesInitial extends AddImagesState {}

class UploadImagesLoading extends AddImagesState {}

// ignore: must_be_immutable
class AddImagesSuccess extends AddImagesState {
  List<File> image = [];
  AddImagesSuccess({required this.image});
}

// ignore: must_be_immutable
class AddImagesFailure extends AddImagesState {
  String errMessage;
  AddImagesFailure({
    required this.errMessage,
  });
}

// ignore: must_be_immutable
class UploadImagesSuccess extends AddImagesState {
  List<String> url = [];
  UploadImagesSuccess({required this.url});
}

// ignore: must_be_immutable
class UploadImagesFailure extends AddImagesState {
  String errMessage;
  UploadImagesFailure({
    required this.errMessage,
  });
}
