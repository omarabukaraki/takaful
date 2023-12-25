import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdApplication extends StatelessWidget {
  const AdApplication({
    required this.image,
    super.key,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return CircularProgressIndicator(
              value: downloadProgress.progress,
              strokeWidth: 0,
            );
          },
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
