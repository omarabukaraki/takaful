import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takaful/features/get_donation/data/model/donation_model.dart';
import 'package:takaful/features/get_donation/presentation/cubit/get_donation_cubit/get_donation_cubit.dart';
import 'package:takaful/features/get_donation/presentation/views/donation_details_page.dart';
import 'package:takaful/features/get_donation/presentation/views/widget/donation_widget/donation_component.dart';
import 'package:takaful/core/widgets/custom_search_bar.dart';
import 'package:takaful/core/utils/app_strings.dart';
import 'package:takaful/notification_services.dart';
import 'home_page_content.dart';
import 'widget/home_page_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchName = '';
  List<DonationModel> donation = [];
  List<String> donationId = [];
  @override
  void initState() {
    changeUserToken();
    getForegroundNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const HomePageAppBar(),
      body: Column(
        children: [
          //start search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: CustomSearchBar(
                onChanged: (value) {
                  setState(() {
                    searchName = value;
                  });
                },
                icon: const Icon(Icons.search),
                hintText: AppString.textSearchInTakaful),
          ),
          //end search bar

          searchName == ''
              //start display home page content
              ? Expanded(child: HomePageContent(screenWidth: screenWidth))
              //end display home page content

              //start get donation by title of donation
              : searchDonation(searchName),
          //end get donation by title of donation
        ],
      ),
    );
  }

  Widget searchDonation(String searchName) {
    BlocProvider.of<GetDonationCubit>(context)
        .getDonationBySearch(searchName: searchName);
    return BlocConsumer<GetDonationCubit, GetDonationState>(
      listener: (context, state) {
        if (state is GetDonationSuccess) {
          donation = state.donations;
          donationId = state.docId;
        }
      },
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
              itemCount: donation.length,
              itemBuilder: (context, index) => donation[index].isTaken != true
                  ? DonationComponent(
                      donation: donation[index],
                      donationId: donationId[index],
                      onTapRequest: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DonationDetailsPage(
                                      donation: donation[index],
                                      docId: donationId[index],
                                    )));
                      },
                    )
                  : const SizedBox()),
        );
      },
    );
  }
}
