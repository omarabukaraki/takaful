class NotificationModel {
  String userId;
  String typeOfNotification;
  String acceptTime;
  String donarEmail;
  String titleNotification;
  String bodyNotification;

  NotificationModel(
      {required this.titleNotification,
      required this.donarEmail,
      required this.userId,
      required this.typeOfNotification,
      required this.acceptTime,
      required this.bodyNotification});

  factory NotificationModel.fromJson(jsonData) {
    return NotificationModel(
        bodyNotification: jsonData['bodyNotification'],
        titleNotification: jsonData['titleNotification'],
        donarEmail: jsonData['donarEmail'],
        userId: jsonData['userId'],
        typeOfNotification: jsonData['typeOfNotification'],
        acceptTime: jsonData['acceptTime']);
  }
}
