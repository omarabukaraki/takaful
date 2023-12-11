class RequestDonationModel {
  final String serviceReceiverId;
  final String donarAccount;
  final String serviceReceiverAccount;
  final String titleDonation;
  final String timeRequest;
  final String donationId;
  final bool isApproved;
  RequestDonationModel(
      {required this.donationId,
      required this.serviceReceiverId,
      required this.donarAccount,
      required this.serviceReceiverAccount,
      required this.timeRequest,
      required this.titleDonation,
      required this.isApproved});
  factory RequestDonationModel.fromJson(jsonData) {
    return RequestDonationModel(
        donationId: jsonData['donationId'],
        serviceReceiverId: jsonData['serviceReceiverId'],
        donarAccount: jsonData['donarAccount'],
        serviceReceiverAccount: jsonData['serviceReceiverAccount'],
        timeRequest: jsonData['timeRequest'],
        titleDonation: jsonData['titleDonation'],
        isApproved: jsonData['isApproved']);
  }
}
