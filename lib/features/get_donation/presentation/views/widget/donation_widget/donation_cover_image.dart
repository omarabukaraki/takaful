import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DonationCoverImage extends StatelessWidget {
  const DonationCoverImage({
    this.image,
    super.key,
  });
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 5),
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))
            ],
          ),
          child: CachedNetworkImage(
            imageUrl: image!,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
              strokeWidth: 1,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }
}
// Image(
//             image: CachedNetworkImageProvider(image!),
//             fit: BoxFit.cover,
//           )),