class RequestDonationModel {
  // String serviceReceiverId;
  String donarAccount;
  String serviceReceiverAccount;
  String titleDonation;
  String timeRequest;
  RequestDonationModel(
      {
      // required this.serviceReceiverId,
      required this.donarAccount,
      required this.serviceReceiverAccount,
      required this.timeRequest,
      required this.titleDonation});
  factory RequestDonationModel.fromJson(jsonData) {
    return RequestDonationModel(
        // serviceReceiverId: jsonData['serviceReceiverId'],
        donarAccount: jsonData['donarAccount'],
        serviceReceiverAccount: jsonData['serviceReceiverAccount'],
        timeRequest: jsonData['timeRequest'],
        titleDonation: jsonData['titleDonation']);
  }
}
