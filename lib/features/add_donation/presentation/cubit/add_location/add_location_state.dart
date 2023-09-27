// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_location_cubit.dart';

@immutable
abstract class AddLocationState {}

class AddLocationInitial extends AddLocationState {}

class AddLocationLodging extends AddLocationState {}

// ignore: must_be_immutable
class AddLocationSuccess extends AddLocationState {
  List<Placemark> placemarks = [];
  AddLocationSuccess({
    required this.placemarks,
  });
}

// ignore: must_be_immutable
class AddLocationFailure extends AddLocationState {
  String errMessage;
  AddLocationFailure({
    required this.errMessage,
  });
}
