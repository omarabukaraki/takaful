class CategoryModel {
  String? image;
  String? title;
  String? createAt;
  CategoryModel({this.image, this.title, this.createAt});

  factory CategoryModel.fromJson(jsonData) {
    return CategoryModel(
        image: jsonData['image'],
        title: jsonData['categoryName'],
        createAt: jsonData['createAt']);
  }
}
