class PostModel {
  final String id;
  final bool postState;
  final String title;
  final List<String> image;
  final String category;
  final int count;
  final String itemOrService;
  final String description;
  final String location;
  final String state;
  final String createAt;
  final String donarAccount;
  PostModel(
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

  factory PostModel.fromJson(jsonData) {
    return PostModel(
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
