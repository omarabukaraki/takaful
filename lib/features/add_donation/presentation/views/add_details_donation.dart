import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:takaful/core/helper/show_snak_bar.dart';
import 'package:takaful/core/utils/app_colors.dart';
import 'package:takaful/core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfiled.dart';
import '../cubit/add_donation_cubit/add_donation_cubit.dart';
import '../cubit/add_images_cubit/add_images_cubit.dart';
import '../cubit/add_location/add_location_cubit.dart';
import 'add_images_page.dart';
import 'widgets/counter_post.dart';
import 'widgets/widgets_for_image/add_image_button.dart';
import 'widgets/widgets_for_location/location_button.dart';
import 'widgets/widgets_for_location/location_loading.dart';
import 'widgets/widgets_for_location/text_feiled.dart';
import '../../../../core/widgets/type_of_donation_component.dart';

class AddDetailsPost extends StatefulWidget {
  const AddDetailsPost({super.key});

  static String id = 'AddDetailsPost';

  @override
  State<AddDetailsPost> createState() => _AddDetailsPostState();
}

class _AddDetailsPostState extends State<AddDetailsPost> {
  int counter = 0;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController locationSubLocality = TextEditingController();
  TextEditingController locationLocality = TextEditingController();
  TextEditingController stateOfThePost = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isLoading = false;
  bool isLocationLoading = false;
  bool addedImage = false;
  bool addedLocation = false;
  // List<String> urls = [];
  List<Placemark> placemarks = [];

  String typeOfDonation = 'معروض';

  void clearText() {
    title.clear();
    locationSubLocality.clear();
    stateOfThePost.clear();
    description.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> categoryAndItemService =
        ModalRoute.of(context)!.settings.arguments as List<String?>;
    return Scaffold(
        appBar: CustomAppBar(
          textOne: categoryAndItemService[0],
          textTwo: AppString.textAddDetailsToDonation,
          button: true,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: BlocConsumer<AddDonationCubit, AddDonationState>(
          listener: (context, state) {
            if (state is AddDonationLodging) {
              isLoading = true;
            } else if (state is AddDonationSuccess) {
              isLoading = false;
              clearText();
              counter = 0;
              BlocProvider.of<AddImagesCubit>(context).image = [];
              BlocProvider.of<AddImagesCubit>(context).nameImage = [];
              BlocProvider.of<AddImagesCubit>(context).url = [];
              addedImage = false;
              addedLocation = false;

              typeOfDonation = 'معروض';
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     MyDonationPage.id, ((route) => false));
            } else if (state is AddDonationFailure) {
              isLoading = false;
            }
          },
          builder: (context, state) {
            return BlurryModalProgressHUD(
              inAsyncCall: isLoading,
              progressIndicator: const SpinKitFadingCircle(
                  color: AppColor.kPrimary, size: 90.0),
              dismissible: false,
              opacity: 0.4,
              child: Form(
                key: formKey,
                child: ListView(children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(right: 29),
                    child: Text(
                      AppString.textAddImageToDonation,
                      style: TextStyle(fontSize: 17, color: AppColor.kFont),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //start get images from user
                  //
                  BlocConsumer<AddImagesCubit, AddImagesState>(
                    listener: (context, state) {
                      addedImage = true;
                    },
                    builder: (context, state) {
                      return addedImage != true
                          ? GestureDetector(
                              onTap: () {
                                BlocProvider.of<AddImagesCubit>(context).image =
                                    [];
                                BlocProvider.of<AddImagesCubit>(context).url =
                                    [];
                                BlocProvider.of<AddImagesCubit>(context)
                                    .nameImage = [];
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const AddImagesPage();
                                  },
                                ));
                              },
                              child: const AddImageButton(
                                  icon: Icons.image,
                                  text: AppString.textAddImageToDonation))
                          : const AddImageButton();
                    },
                  ),
                  //
                  //end get images from user

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

                  //start get location from user
                  //
                  BlocConsumer<AddLocationCubit, AddLocationState>(
                    listener: (context, state) {
                      if (state is AddLocationLodging) {
                        isLocationLoading = true;
                      } else if (state is AddLocationSuccess) {
                        addedLocation = true;
                        isLocationLoading = false;
                        placemarks = state.placemarks;
                        locationSubLocality.text =
                            placemarks[0].subLocality.toString();
                        locationLocality.text =
                            placemarks[0].locality.toString();
                      } else if (state is AddLocationFailure) {
                        isLocationLoading = false;
                        showSankBar(context, state.errMessage);
                      }
                    },
                    builder: (context, state) {
                      return addedLocation != true
                          ? SizedBox(
                              child: isLocationLoading == false
                                  ? LocationButton(
                                      onTap: () {
                                        BlocProvider.of<AddLocationCubit>(
                                                context)
                                            .getPosition();
                                      },
                                    )
                                  : const LocationLoadingIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextFieldForLocation(
                                        controller: locationSubLocality,
                                        hintText: placemarks[0].subLocality,
                                        onChanged: (value) {
                                          locationSubLocality.text = value;
                                        },
                                        icon: const Icon(Icons.location_on),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextFieldForLocation(
                                          controller: locationLocality,
                                          // readOnly: true,
                                          onChanged: (p0) {
                                            locationLocality.text = p0;
                                          },
                                          hintText: placemarks[0].locality,
                                          icon: const Icon(
                                              Icons.location_city_rounded)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                  //
                  //end get location from user

                  //start get type of donation
                  TypeOfDonationComponent(
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
                    typeOfDonation: typeOfDonation,
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
                  categoryAndItemService[0]!.length <= 5
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
                  const SizedBox(height: 10),

                  //start button to upload donation
                  CustomButton(
                    circular: 20,
                    text: AppString.textPublishDonation,
                    onTap: () async {
                      if (BlocProvider.of<AddImagesCubit>(context)
                          .url
                          .isEmpty) {
                        showSankBar(context, 'الرجاء اضافة صور',
                            color: AppColor.kRed);
                      } else {
                        if (formKey.currentState!.validate()) {
                          if (placemarks.isNotEmpty) {
                            BlocProvider.of<AddDonationCubit>(context).addPost(
                              postState: true,
                              title: title.text,
                              image:
                                  BlocProvider.of<AddImagesCubit>(context).url,
                              category: categoryAndItemService[1]!,
                              itemOrService: categoryAndItemService[0]!,
                              description: description.text,
                              location: placemarks[0].locality!,
                              subLocation: locationSubLocality.text,
                              state: stateOfThePost.text,
                              count: counter,
                              typeOfDonation: typeOfDonation,
                            );
                          } else {
                            showSankBar(context, 'الرجاء اضافة الموقع');
                          }
                        }
                      }
                    },
                    textColor: AppColor.kWhite,
                    color: AppColor.kPrimary,
                  ),
                  //end button to upload donation
                  const SizedBox(height: 20)
                ]),
              ),
            );
          },
        ));
  }
}
  // '${placemarks[0].locality} - ${locationSubLocality.text}'