import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/core/widgets/custom_app_bar.dart';
import 'package:takaful/core/widgets/custom_textfiled.dart';
import 'package:takaful/features/add_donation/presentation/views/widgets/counter_post.dart';
import 'package:takaful/features/add_donation/presentation/views/widgets/widgets_for_type_of_donations/type_of_donation_component.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/donation_details_page.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_Info.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_cover_image.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/image_count.dart';

import '../../../../core/widgets/custom_button.dart';

class MyDonationPage extends StatefulWidget {
  const MyDonationPage({super.key});
  static String id = 'MyDonationPage';
  @override
  State<MyDonationPage> createState() => _MyDonationPageState();
}

class _MyDonationPageState extends State<MyDonationPage> {
  List<DonationModel> donation = [];
  List docId = [];
  @override
  void initState() {
    BlocProvider.of<GetDonationCubit>(context).getPost();
    super.initState();
  }

  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(button: false, textOne: 'تبرعاتي', textTwo: ''),
      body: BlocConsumer<GetDonationCubit, GetDonationState>(
        listener: (context, state) {
          if (state is GetDonationSuccess) {
            donation = state.donations;
            docId = state.docId;
            print(docId);
          }
        },
        builder: (context, state) {
          return ListView.builder(
            itemCount: donation.length,
            itemBuilder: (context, index) {
              return donation[index].id ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? MyDonationComponent(
                      donation: donation[index],
                      onTapDelete: () async {
                        try {
                          await FirebaseFirestore.instance
                              .collection('donations')
                              .doc(docId[index])
                              .delete();
                        } catch (e) {
                          print(e);
                        }
                      },
                      onTapEdit: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TextOne(
                                      donation: donation[index],
                                    )));
                      },
                    )
                  : const SizedBox();
            },
          );
        },
      ),
    );
  }
}

class TextOne extends StatefulWidget {
  const TextOne({super.key, this.donation});
  // final String? image;
  final DonationModel? donation;
  @override
  State<TextOne> createState() => _TextOneState();
}

class _TextOneState extends State<TextOne> {
  int counter = 0;
  bool isSelectedOne = false;
  bool isSelectedTwo = true;
  String typeOfDonation = 'معروض';
  TextEditingController title = TextEditingController();
  TextEditingController locationSubLocality = TextEditingController();
  TextEditingController locationLocality = TextEditingController();
  TextEditingController stateOfThePost = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    title.text = widget.donation!.title;
    stateOfThePost.text = widget.donation!.state;
    description.text = widget.donation!.description;
    counter = widget.donation!.count;
    typeOfDonation = widget.donation!.typeOfDonation;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.donation!.image[0]),
                      fit: BoxFit.fill)),
            ),
            //start get title from user
            CustomTextFiled(
              controller: title,
              onChanged: (postTitle) {
                title.text = postTitle;
              },
              hintText: AppString.textTitle,
              icon: const Icon(Icons.title_rounded),
            ),
            //end get title from user
            //start get type of donation
            TypeOfDonationComponent(
              onTapRequired: () {
                setState(() {
                  isSelectedOne = true;
                  isSelectedTwo = false;
                  typeOfDonation = 'مطلوب';
                });
              },
              onTapShown: () {
                setState(() {
                  isSelectedOne = false;
                  isSelectedTwo = true;
                  typeOfDonation = 'معروض';
                });
              },
            ),
            //end get type of donation

            //start get state from user
            CustomTextFiled(
              controller: stateOfThePost,
              onChanged: (p0) {
                stateOfThePost.text = p0;
              },
              hintText: AppString.textState,
              icon: const Icon(Icons.fiber_new_rounded),
            ),
            //end get state from user
            //start get count from user
            widget.donation!.category != "الخدمات"
                ? CounterPost(
                    counter: counter,
                    onTapAdd: () {
                      setState(() {
                        if (counter < 500) {
                          counter++;
                        } else {
                          counter = 500;
                        }
                      });
                    },
                    onTapRemove: () {
                      setState(() {
                        if (counter > 0) {
                          counter--;
                        } else {
                          counter = 0;
                        }
                      });
                    },
                  )
                : const SizedBox(),
            //end get count from user
            //start get desorption from user
            CustomTextFiled(
              controller: description,
              onChanged: (postDescription) {
                description.text = postDescription;
              },
              hintText: AppString.textDescription,
              icon: const Icon(Icons.description),
            ),
            //end get desorption from user
            //start button to upload donation
            const SizedBox(height: 10),
            CustomButton(
              circular: 20,
              text: AppString.textPublishDonation,
              onTap: () async {},
              textColor: AppColor.kWhite,
              color: AppColor.kPrimary,
            ),
            const SizedBox(height: 10),
            //end button to upload donation
          ]),
        ),
      ),
    );
  }
}

class MyDonationComponent extends StatelessWidget {
  const MyDonationComponent(
      {super.key, this.onTapEdit, this.onTapDelete, this.donation});
  final DonationModel? donation;

  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DonationCoverInformation(
                        title: donation!.title,
                        typePost:
                            '${donation!.category} - ${donation!.itemOrService}',
                        location: donation!.location),
                  ),
                  Expanded(
                      flex: 1,
                      child: DonationCoverImage(
                        image: donation!.image[0],
                      )),
                ],
              )),
          Expanded(
              flex: 1, child: ImageCount(countImage: donation!.image.length)),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapDelete,
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                          color: AppColor.kRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          'حذف',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapEdit,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.kPrimary),
                        child: const Center(
                            child: Text(
                          'تعديل',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
