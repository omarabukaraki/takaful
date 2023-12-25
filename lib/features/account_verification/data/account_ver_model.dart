// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccountVreModel {
  String image;
  String userEmail;

  AccountVreModel({
    required this.image,
    required this.userEmail,
  });

  factory AccountVreModel.fromJson(jsonData) {
    return AccountVreModel(
        image: jsonData['image'], userEmail: jsonData['userEmail']);
  }
}
