import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/auth/data/model/user_details_model.dart';
import 'package:takaful/features/get_donation/presentation/views/donation_details_page.dart';
import 'package:takaful/features/profile/presentation/cubit/get_user_details/get_user_details_cubit.dart';

class DonarAccountBox extends StatefulWidget {
  const DonarAccountBox({
    super.key,
    required this.widget,
  });

  final DonationDetailsPage widget;

  @override
  State<DonarAccountBox> createState() => _DonarAccountBoxState();
}

class _DonarAccountBoxState extends State<DonarAccountBox> {
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsCubit>(context).userDonationInformation(
        email: widget.widget.donationModel!.donarAccount);
    super.initState();
  }

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
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userDetailsModel != null ? userDetailsModel!.name : '',
                        // widget.postModel!.donarName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_purple500_sharp,
                            color: Colors.yellow,
                            size: 20,
                          ),
                        ],
                      )
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
                        imageUrl: userDetailsModel != null
                            ? userDetailsModel!.image
                            : 'https://firebasestorage.googleapis.com/v0/b/takafultest-2ef6f.appspot.com/o/imagesForApplication%2Fuser_image.jpg?alt=media&token=1742bede-af30-493e-8e79-b08ca3c7bb0f',
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
            );
          },
        ));
  }
}
