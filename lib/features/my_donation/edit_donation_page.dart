import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/core/utils/app_strings.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textfiled.dart';
import '../../../../../core/widgets/type_of_donation_component.dart';
import '../add_donation/presentation/views/widgets/counter_post.dart';
import '../get_donation/data/model/donation_model.dart';
import 'cubit/cubit/edit_and_delete_donation_cubit.dart';
import 'widget/image_donation_cover.dart';

class EditDonationPage extends StatefulWidget {
  const EditDonationPage({super.key, this.docId, this.donation});

  final DonationModel? donation;
  final String? docId;
  @override
  State<EditDonationPage> createState() => _EditDonationPageState();
}

class _EditDonationPageState extends State<EditDonationPage> {
  int count = 0;
  String typeOfDonation = '';
  TextEditingController title = TextEditingController();
  TextEditingController stateOfThePost = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    count = widget.donation!.count;
    typeOfDonation = widget.donation!.typeOfDonation;
    title.text = widget.donation!.title;
    stateOfThePost.text = widget.donation!.state;
    description.text = widget.donation!.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAndDeleteDonationCubit, EditAndDeleteDonationState>(
      listener: (context, state) {
        if (state is EditDonationLoading) {
          isLoading = true;
        } else if (state is EditDonationSuccess) {
          isLoading = false;
        } else if (state is EditDonationFailure) {
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: BlurryModalProgressHUD(
              inAsyncCall: isLoading,
              child: SingleChildScrollView(
                child: Column(children: [
                  //start display image
                  ImageDonationCover(widget: widget),
                  //end display image

                  //start get title from user
                  CustomTextFiled(
                    controller: title,
                    onChanged: (postTitle) {
                      title.text = postTitle;
                    },
                    hintText: widget.donation!.title,
                    icon: const Icon(Icons.title_rounded),
                  ),
                  //end get title from user

                  //start get type of donation
                  TypeOfDonationComponent(
                    typeOfDonation: typeOfDonation,
                    onTapRequired: () {
                      setState(() {
                        typeOfDonation = 'مطلوب';
                      });
                    },
                    onTapShown: () {
                      setState(() {
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
                    hintText: widget.donation!.state,
                    icon: const Icon(Icons.fiber_new_rounded),
                  ),
                  //end get state from user

                  //start get count from user
                  widget.donation!.category != "الخدمات"
                      ? CounterPost(
                          counter: count,
                          onTapAdd: () {
                            setState(() {
                              if (count < 500) {
                                count++;
                              } else {
                                count = 500;
                              }
                            });
                          },
                          onTapRemove: () {
                            setState(() {
                              if (count > 0) {
                                count--;
                              } else {
                                count = 0;
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
                    hintText: widget.donation!.description,
                    icon: const Icon(Icons.description),
                  ),
                  //end get desorption from user
                  const SizedBox(height: 10),
                  //start button to edit donation
                  CustomButton(
                    circular: 20,
                    text: AppString.textSaveEdit,
                    onTap: () async {
                      await BlocProvider.of<EditAndDeleteDonationCubit>(context)
                          .editDonationData(
                              docId: widget.docId!,
                              title: title.text,
                              typeOfDonation: typeOfDonation,
                              state: stateOfThePost.text,
                              count: count,
                              description: description.text);
                    },
                    textColor: AppColor.kWhite,
                    color: AppColor.kPrimary,
                  ),
                  const SizedBox(height: 10),
                  //end button to edit donation
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
