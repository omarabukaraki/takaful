import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/home/data/ad_model.dart';
part 'get_ads_state.dart';

class GetAdsCubit extends Cubit<GetAdsState> {
  GetAdsCubit() : super(GetAdsInitial());

  CollectionReference ads = FirebaseFirestore.instance.collection('ad');

  void getAd() {
    emit(GetAdsLoading());
    try {
      ads.snapshots().listen((event) {
        List<AdModel> adList = [];
        for (var doc in event.docs) {
          adList.add(AdModel.fromJson(doc));
        }
        emit(GetAdsSuccess(adList: adList));
      });
    } catch (e) {
      emit(GetAdsFailure());
    }
  }
}
