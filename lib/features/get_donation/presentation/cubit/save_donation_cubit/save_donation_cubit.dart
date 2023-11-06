import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:takaful/features/get_donation/presentation/cubit/save_donation_cubit/save_donation_model.dart';
part 'save_donation_state.dart';

class SaveDonationCubit extends Cubit<SaveDonationState> {
  SaveDonationCubit() : super(SaveDonationInitial());

  CollectionReference SaveDonation =FirebaseFirestore.instance.collection('save donation');
  
  Future<void> saveDonation({required String docId })async{
   await SaveDonation.add({'donationId': docId,'userId':FirebaseAuth.instance.currentUser!.uid});

  }
  void getSavedDonation(){
    List<SaveDonationModel> donationSaved=[];
    SaveDonation.snapshots().listen((event) {
      for (var doc in event.docs) {
      donationSaved.add(SaveDonationModel(donationId:doc['donationId'] , userId:doc['userId'] ));
      }
      emit(SaveDonationSuccess(donationSaved: donationSaved));
     });
  }

}
