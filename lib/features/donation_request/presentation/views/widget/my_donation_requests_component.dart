// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/features/donation_request/presentation/views/widget/my_donation_requests_button.dart';

import 'accept_widget.dart';

class MyDonationRequestsItem extends StatelessWidget {
  const MyDonationRequestsItem({
    Key? key,
    required this.title,
    this.nameUser,
    this.time,
    this.onTapAccept,
    this.onTapReject,
    required this.image,
    required this.isApproved,
    required this.isVerified,
  }) : super(key: key);
  final String title;
  final String? nameUser;
  final String? time;
  final VoidCallback? onTapAccept;
  final VoidCallback? onTapReject;
  final String image;
  final bool isApproved;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //start Icon button
                      const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 40, top: 2),
                          child: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: AppColor.kPrimary,
                          ),
                        ),
                      ),
                      //end Icon button

                      //start title
                      Expanded(
                        flex: 4,
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 15,
                              color: AppColor.kFont,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                //end title
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isVerified
                          ? const Icon(Icons.verified,
                              color: Colors.blue, size: 16)
                          : const SizedBox(),
                      const SizedBox(width: 5),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(' اسم الطالب' ':' ' $nameUser',
                            style: const TextStyle(
                                fontSize: 11,
                                color: AppColor.kFont,
                                overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  ),
                ),

                Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //start button accept and reject
                        Expanded(
                          flex: 2,
                          child: isApproved == !true
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: MyDonationRequestsButton(
                                          onTap: onTapReject,
                                          colorAndBorder: false,
                                          nameButton: 'رفض',
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: MyDonationRequestsButton(
                                        onTap: onTapAccept,
                                        colorAndBorder: true,
                                        nameButton: 'قبول',
                                      ),
                                    ),
                                  ],
                                )
                              : const AcceptWidget(),
                        ),
                        //end button accept and reject

                        const SizedBox(width: 5),

                        //start display time of notification
                        Expanded(
                          flex: 2,
                          child: Text(
                            time.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        //end display time of notification
                      ],
                    )),
              ]),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 1))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
