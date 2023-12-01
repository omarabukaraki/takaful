import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../edit_donation_page.dart';

class ImageDonationCover extends StatelessWidget {
  const ImageDonationCover({
    super.key,
    required this.widget,
  });

  final EditDonationPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 1.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 2), blurRadius: 5),
          ]),
      child: CachedNetworkImage(
        imageUrl: widget.donation!.image[0],
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(
          value: downloadProgress.progress,
          strokeWidth: 1,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
