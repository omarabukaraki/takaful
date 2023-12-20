// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_category_cubit.dart';

abstract class GetCategoryState {}

class GetCategoryInitial extends GetCategoryState {}

// ignore: must_be_immutable
class GetCategorySuccess extends GetCategoryState {
  List<CategoryModel> categoryList;
  GetCategorySuccess({
    required this.categoryList,
  });
}

class GetCategoryLoading extends GetCategoryState {}

class GetCategoryFailure extends GetCategoryState {}
