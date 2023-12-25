class AdModel {
  String createAt;
  String image;
  AdModel({required this.createAt, required this.image});

  factory AdModel.fromJson(jsonData) {
    return AdModel(createAt: jsonData['createAt'], image: jsonData['image']);
  }
}
