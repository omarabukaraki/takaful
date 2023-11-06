class SaveDonationModel{
  String donationId ;
  String userId;
  SaveDonationModel({required this.donationId,required this.userId});
  factory SaveDonationModel.fromJson(jsonData){
    return SaveDonationModel(donationId: jsonData['donationId'], userId: jsonData['userId']);
  }

}