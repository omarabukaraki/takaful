// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserDetailsModel {
  String name;
  String email;
  String mobileNumber;
  String image;
  UserDetailsModel({
    required this.image,
    required this.name,
    required this.email,
    required this.mobileNumber,
  });
  factory UserDetailsModel.fromJson(data) {
    return UserDetailsModel(
        name: data['name'],
        email: data['email'],
        image: data['image'],
        mobileNumber: data['mobileNumber']);
  }
}
