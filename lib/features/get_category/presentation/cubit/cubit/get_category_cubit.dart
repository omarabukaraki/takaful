import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/category_model.dart';
part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit() : super(GetCategoryInitial());

  CollectionReference itemCategory =
      FirebaseFirestore.instance.collection('category');
  CollectionReference serviceCategory =
      FirebaseFirestore.instance.collection('service category');
  void getCategories({required bool isItem}) {
    emit(GetCategoryLoading());

    isItem == true
        ? itemCategory.orderBy('createAt').snapshots().listen((event) {
            List<CategoryModel> categoryList = [];
            for (var element in event.docs) {
              categoryList.add(CategoryModel.fromJson(element));
            }
            categoryList.add(CategoryModel());
            emit(GetCategorySuccess(categoryList: categoryList));
          })
        : serviceCategory.orderBy('createAt').snapshots().listen((event) {
            List<CategoryModel> categoryList = [];
            for (var element in event.docs) {
              categoryList.add(CategoryModel.fromJson(element));
            }
            categoryList.add(CategoryModel());
            emit(GetCategorySuccess(categoryList: categoryList));
          });
  }
}
