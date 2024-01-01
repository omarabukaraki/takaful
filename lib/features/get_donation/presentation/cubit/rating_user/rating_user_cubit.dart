import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';

import '../../views/helper/equation_for_rating.dart';
part 'rating_user_state.dart';

class RatingUserCubit extends Cubit<RatingUserState> {
  RatingUserCubit() : super(RatingUserInitial());

  CollectionReference user = FirebaseFirestore.instance.collection('users');
  AverageRating averageRating = AverageRating();
  Future<void> ratingUser(
      {required double rating,
      required UserDetailsModel userDetailsModel,
      required String userId}) async {
    for (double i = 1; i <= 5; i++) {
      if (rating == i) {
        await user.doc(userId).update({
          'numberOfRatingUsers': userDetailsModel.numberOfRatingUsers + 1,
          'rating list': [
            userDetailsModel.ratingList[0] + (i == 1 ? 1 : 0),
            userDetailsModel.ratingList[1] + (i == 2 ? 1 : 0),
            userDetailsModel.ratingList[2] + (i == 3 ? 1 : 0),
            userDetailsModel.ratingList[3] + (i == 4 ? 1 : 0),
            userDetailsModel.ratingList[4] + (i == 5 ? 1 : 0),
          ],
        });
      }
    }
  }

  Future<void> updateResult(
      {required UserDetailsModel userDetailsModel,
      required String userId}) async {
    double result = averageRating.calculateAverageRating(
        userDetailsModel.ratingList[0],
        userDetailsModel.ratingList[1],
        userDetailsModel.ratingList[2],
        userDetailsModel.ratingList[3],
        userDetailsModel.ratingList[4],
        userDetailsModel.numberOfRatingUsers);
    await user.doc(userId).update({
      'rating': result,
    });
  }
}
