class DonationModel {
  final String id;
  final bool postState;
  final String title;
  final List<dynamic> image;
  final String category;
  final int count;
  final String itemOrService;
  final String description;
  final String location;
  final String state;
  final String createAt;
  final String donarAccount;
  DonationModel(
    this.id,
    this.postState,
    this.title,
    this.image,
    this.category,
    this.itemOrService,
    this.description,
    this.location,
    this.state,
    this.createAt,
    this.donarAccount,
    this.count,
  );

  factory DonationModel.fromJson(jsonData) {
    return DonationModel(
        jsonData['id'],
        jsonData['postState'],
        jsonData['title'],
        jsonData['image'],
        jsonData['category'],
        jsonData['itemOrService'],
        jsonData['description'],
        jsonData['location'],
        jsonData['count'],
        jsonData['state'],
        jsonData['createAt'],
        jsonData['donarAccount']);
  }
}
