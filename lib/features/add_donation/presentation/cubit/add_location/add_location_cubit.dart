import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  AddLocationCubit() : super(AddLocationInitial());
  Position? cl;
  List<Placemark> placemarks = [];

  Future getPosition() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      emit(AddLocationFailure(errMessage: 'الرجاء تشغيل الموقع'));
    } else {
      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied ||
          per == LocationPermission.deniedForever ||
          per == LocationPermission.unableToDetermine) {
        per = await Geolocator.requestPermission();
        emit(AddLocationLodging());
        await getLatAndLong();
      } else {
        emit(AddLocationLodging());
        await getLatAndLong();
      }
    }
  }

  Future getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    getCountry(cl!.latitude, cl!.longitude);
  }

  Future getCountry(double latitude, double longitude) async {
    try {
      emit(AddLocationLodging());
      placemarks = await placemarkFromCoordinates(latitude, longitude,
          localeIdentifier: 'ar');
      // print(placemarks);
      emit(AddLocationSuccess(placemarks: placemarks));
    } catch (e) {
      emit(AddLocationFailure(errMessage: e.toString()));
    }
  }
}
