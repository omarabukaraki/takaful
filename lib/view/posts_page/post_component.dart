import 'package:flutter/material.dart';
import 'package:takaful/component/image_count.dart';
import 'package:takaful/constant.dart';
import 'package:takaful/models/post_model.dart';
import 'package:takaful/view/posts_page/post_cover_Info.dart';
import 'package:takaful/view/posts_page/post_cover_image.dart';

class CustomPostComponent extends StatelessWidget {
  const CustomPostComponent(
      {super.key, this.onTapRequest, this.onTapSave, this.posts});
  final PostModel? posts;

  final VoidCallback? onTapRequest;
  final VoidCallback? onTapSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PostCoverInformation(
                        title: posts!.title,
                        typePost:
                            '${posts!.category} , ${posts!.itemOrService}',
                        location: posts!.location),
                  ),
                  Expanded(
                      flex: 1,
                      child: PostCoverImage(
                        image: posts!.image,
                      )),
                ],
              )),
          Expanded(flex: 1, child: ImageCount(countImage: posts!.count)),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapSave,
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                            child: Text(
                          'حفظ',
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onTapRequest,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kPrimary),
                        child: const Center(
                            child: Text(
                          'طلب',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
