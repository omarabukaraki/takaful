import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';
import '../../../cubit/rating_user/rating_user_cubit.dart';
import '../../helper/custom_alert_Dialog.dart';
import 'custom_rating_bar.dart';

class DonarAccountBox extends StatefulWidget {
  const DonarAccountBox({
    super.key,
    required this.userId,
    required this.donarAccount,
  });

  final String donarAccount;
  final String userId;

  @override
  State<DonarAccountBox> createState() => _DonarAccountBoxState();
}

class _DonarAccountBoxState extends State<DonarAccountBox> {
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsCubit>(context)
        .userDonationInformation(email: widget.donarAccount);
    super.initState();
  }

  double rating = 0.0;
  bool isRated = false;
  UserDetailsModel? userDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ],
            color: Colors.white),
        child: BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
          listener: (context, state) {
            if (state is GetUserDetailsSuccessForDonation) {
              userDetailsModel = state.user;
            }
          },
          builder: (context, state) {
            return userDetailsModel != null
                ? Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                userDetailsModel!.isVerified == true
                                    ? const Icon(Icons.verified,
                                        color: Colors.blue, size: 19)
                                    : const SizedBox(),
                                const SizedBox(width: 5),
                                Text(
                                  userDetailsModel!.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            widget.donarAccount !=
                                    FirebaseAuth.instance.currentUser!.email
                                ? isRated != true
                                    ? GestureDetector(
                                        onTap: () {
                                          awesomeDialogForRating(
                                            context: context,
                                            onRatingUpdate: (value) {
                                              setState(() {
                                                rating = value;
                                              });
                                            },
                                            btnOkOnPress: () async {
                                              if (rating != 0.0) {
                                                await BlocProvider.of<
                                                            RatingUserCubit>(
                                                        context)
                                                    .ratingUser(
                                                        rating: rating,
                                                        userDetailsModel:
                                                            userDetailsModel!,
                                                        userId: widget.userId);
                                                // ignore: use_build_context_synchronously
                                                await BlocProvider.of<
                                                            RatingUserCubit>(
                                                        context)
                                                    .updateResult(
                                                        userDetailsModel:
                                                            userDetailsModel!,
                                                        userId: widget.userId);
                                              } else {
                                                // print('object');
                                              }
                                              setState(() {
                                                rating = 0;
                                                isRated = true;
                                              });
                                            },
                                          ).show();
                                        },
                                        child: CustomRatingBar(
                                            userDetailsModel: userDetailsModel),
                                      )
                                    : CustomRatingBar(
                                        isRating: true,
                                        userDetailsModel: userDetailsModel)
                                : CustomRatingBar(
                                    isRating: widget.donarAccount ==
                                        FirebaseAuth
                                            .instance.currentUser!.email,
                                    userDetailsModel: userDetailsModel),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: CachedNetworkImage(
                              imageUrl: userDetailsModel!.image,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                return CircularProgressIndicator(
                                    value: downloadProgress.progress);
                              },
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ));
  }
}


//  onRatingUpdate: (value) {
//                                               setState(() {
//                                                 rating = value;
//                                               });
//                                             },
                      // btnOkOnPress: () async {
                      //             for (double i = 1; i <= 5; i++) {
                      //               if (rating == i) {
                      //                 await user.doc(widget.userId).update({
                      //                   'numberOfRatingUsers':
                      //                       userDetailsModel!
                      //                               .numberOfRatingUsers +
                      //                           1,
                      //                   'rating list': [
                      //                     userDetailsModel!.ratingList[0] +
                      //                         (i == 1 ? 1 : 0),
                      //                     userDetailsModel!.ratingList[1] +
                      //                         (i == 2 ? 1 : 0),
                      //                     userDetailsModel!.ratingList[2] +
                      //                         (i == 3 ? 1 : 0),
                      //                     userDetailsModel!.ratingList[3] +
                      //                         (i == 4 ? 1 : 0),
                      //                     userDetailsModel!.ratingList[4] +
                      //                         (i == 5 ? 1 : 0),
                      //                   ],
                      //                 });
                      //               }
                      //             }

                      //             double result = calculateAverageRating(
                      //                 userDetailsModel!.ratingList[0],
                      //                 userDetailsModel!.ratingList[1],
                      //                 userDetailsModel!.ratingList[2],
                      //                 userDetailsModel!.ratingList[3],
                      //                 userDetailsModel!.ratingList[4],
                      //                 userDetailsModel!.numberOfRatingUsers);

                      //             await user.doc(widget.userId).update({
                      //               'rating': result,
                      //             });
                      //           },

                                    // if (rating == 1) {
                                    //   await user.doc(widget.userId).update({
                                    //     'numberOfRatingUsers': userDetailsModel!
                                    //             .numberOfRatingUsers +
                                    //         1,
                                    //     'rating list': [
                                    //       userDetailsModel!.ratingList[0] + 1,
                                    //       userDetailsModel!.ratingList[1],
                                    //       userDetailsModel!.ratingList[2],
                                    //       userDetailsModel!.ratingList[3],
                                    //       userDetailsModel!.ratingList[4]
                                    //     ],
                                    //   });
                                    // } else if (rating == 2) {
                                    //   await user.doc(widget.userId).update({
                                    //     'numberOfRatingUsers': userDetailsModel!
                                    //             .numberOfRatingUsers +
                                    //         1,
                                    //     'rating list': [
                                    //       userDetailsModel!.ratingList[0],
                                    //       userDetailsModel!.ratingList[1] + 1,
                                    //       userDetailsModel!.ratingList[2],
                                    //       userDetailsModel!.ratingList[3],
                                    //       userDetailsModel!.ratingList[4]
                                    //     ],
                                    //   });
                                    // } else if (rating == 3) {
                                    //   await user.doc(widget.userId).update({
                                    //     'numberOfRatingUsers': userDetailsModel!
                                    //             .numberOfRatingUsers +
                                    //         1,
                                    //     'rating list': [
                                    //       userDetailsModel!.ratingList[0],
                                    //       userDetailsModel!.ratingList[1],
                                    //       userDetailsModel!.ratingList[2] + 1,
                                    //       userDetailsModel!.ratingList[3],
                                    //       userDetailsModel!.ratingList[4]
                                    //     ],
                                    //   });
                                    // } else if (rating == 4) {
                                    //   await user.doc(widget.userId).update({
                                    //     'numberOfRatingUsers': userDetailsModel!
                                    //             .numberOfRatingUsers +
                                    //         1,
                                    //     'rating list': [
                                    //       userDetailsModel!.ratingList[0],
                                    //       userDetailsModel!.ratingList[1],
                                    //       userDetailsModel!.ratingList[2],
                                    //       userDetailsModel!.ratingList[3] + 1,
                                    //       userDetailsModel!.ratingList[4]
                                    //     ],
                                    //   });
                                    // } else if (rating == 5) {
                                    //   await user.doc(widget.userId).update({
                                    //     'numberOfRatingUsers': userDetailsModel!
                                    //             .numberOfRatingUsers +
                                    //         1,
                                    //     'rating list': [
                                    //       userDetailsModel!.ratingList[0],
                                    //       userDetailsModel!.ratingList[1],
                                    //       userDetailsModel!.ratingList[2],
                                    //       userDetailsModel!.ratingList[3],
                                    //       userDetailsModel!.ratingList[4] + 1,
                                    //     ],
                                    //   });
                                    // }