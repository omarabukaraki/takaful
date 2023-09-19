import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostCoverImage extends StatelessWidget {
  const PostCoverImage({
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
          borderRadius: BorderRadius.circular(15),
          // image:
          //     DecorationImage(image: NetworkImage(image!), fit: BoxFit.cover),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: image!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
