class UserDetailsModel {
  String id;
  String name;
  String email;
  String mobileNumber;
  String image;
  String userToken;
  bool isVerified;

  UserDetailsModel({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.userToken,
    required this.isVerified,
  });

  factory UserDetailsModel.fromJson(data) {
    return UserDetailsModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      image: data['image'],
      mobileNumber: data['mobileNumber'],
      userToken: data['userToken'],
      isVerified: data['isVerified'],
    );
  }
}
