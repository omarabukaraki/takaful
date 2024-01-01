class UserDetailsModel {
  String id;
  String name;
  String email;
  String mobileNumber;
  String image;
  String userToken;
  double rating;
  List<dynamic> ratingList;
  int numberOfRatingUsers;
  bool isVerified;

  UserDetailsModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.email,
      required this.mobileNumber,
      required this.userToken,
      required this.isVerified,
      required this.rating,
      required this.ratingList,
      required this.numberOfRatingUsers});

  factory UserDetailsModel.fromJson(data) {
    return UserDetailsModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      image: data['image'],
      mobileNumber: data['mobileNumber'],
      userToken: data['userToken'],
      rating: data['rating'],
      ratingList: data['rating list'],
      numberOfRatingUsers: data['numberOfRatingUsers'],
      isVerified: data['isVerified'],
    );
  }
}
