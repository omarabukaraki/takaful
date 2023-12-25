part of 'get_ads_cubit.dart';

abstract class GetAdsState {}

class GetAdsInitial extends GetAdsState {}

class GetAdsSuccess extends GetAdsState {
  List<AdModel> adList;
  GetAdsSuccess({required this.adList});
}

class GetAdsLoading extends GetAdsState {}

class GetAdsFailure extends GetAdsState {}
