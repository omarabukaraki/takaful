import 'package:flutter/material.dart';
import 'package:takaful/view/items_page/items_type_page.dart';
import 'package:takaful/features/add_donation/presentation/views/add_details_donation.dart';
import 'package:takaful/features/add_donation/presentation/views/add_item_donation.dart';
import 'package:takaful/features/add_donation/presentation/views/add_service_donation.dart';
import 'package:takaful/view/notifcation_page.dart';
import 'package:takaful/features/get_donation/presentation/views/donations_page.dart';
import 'package:takaful/view/servives_pages/service_type_page.dart';

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
  };
}
