import 'package:flutter/material.dart';
import 'package:takaful/features/get_category/presentation/views/items_type_page.dart';
import 'package:takaful/features/add_donation/presentation/views/add_details_donation.dart';
import 'package:takaful/features/add_donation/presentation/views/add_item_donation.dart';
import 'package:takaful/features/add_donation/presentation/views/add_service_donation.dart';
import 'package:takaful/features/notification/presentation/views/notifcation_page.dart';
import 'package:takaful/features/get_donation/presentation/views/donations_page.dart';
import 'package:takaful/features/get_category/presentation/views/service_type_page.dart';
import 'package:takaful/features/profile/presentation/views/my_donation/my_donation_page.dart';
import 'package:takaful/features/profile/presentation/views/profile_page.dart';

abstract class AppRoutes {
  static Map<String, Widget Function(BuildContext)> route =
      <String, WidgetBuilder>{
    AddServiceDonation.id: (context) => AddServiceDonation(),
    AddItemDonation.id: (context) => AddItemDonation(),
    AddDetailsPost.id: (context) => const AddDetailsPost(),
    ItemTypePage.id: (context) => const ItemTypePage(),
    ServiceTypePage.id: (context) => const ServiceTypePage(),
    NotificationPage.id: (context) => const NotificationPage(),
    DonationsPage.id: (context) => const DonationsPage(),
    MyDonationPage.id: (context) => const MyDonationPage(),
    ProfilePage.id: (context) => const ProfilePage(),
  };
}
