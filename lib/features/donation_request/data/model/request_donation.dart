class RequestDonationModel {
  String serviceReceiverId;
  String donarAccount;
  String serviceReceiverAccount;
  String titleDonation;
  String timeRequest;
  String postId;
  RequestDonationModel(
      {required this.postId,
      required this.serviceReceiverId,
      required this.donarAccount,
      required this.serviceReceiverAccount,
      required this.timeRequest,
      required this.titleDonation});
  factory RequestDonationModel.fromJson(jsonData) {
    return RequestDonationModel(
        postId: jsonData['postId'],
        serviceReceiverId: jsonData['serviceReceiverId'],
        donarAccount: jsonData['donarAccount'],
        serviceReceiverAccount: jsonData['serviceReceiverAccount'],
        timeRequest: jsonData['timeRequest'],
        titleDonation: jsonData['titleDonation']);
  }
}
