import 'package:flutter/material.dart';
import 'package:takaful/view/items_page/items_type_page.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_details_post_page.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_item_donation.dart';
import 'package:takaful/view/navigator_bar_pages/add_donation_pages/add_service_donation.dart';
import 'package:takaful/view/notifcation_page.dart';
import 'package:takaful/view/posts_page/posts_page.dart';
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
    PostsPage.id: (context) => const PostsPage(),
  };
}
