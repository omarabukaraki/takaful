import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:takaful/component/image_count.dart';
import 'package:takaful/models/post_model.dart';

import '../../constant.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, this.postModel});
  final PostModel? postModel;
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int inIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Stack(children: [
                CarouselSlider.builder(
                  // carouselController: _controller,
                  itemCount: 1,
                  itemBuilder: (context, index, realIndex) {
                    return ImagePostComponent(
                      image: widget.postModel!.image,
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    height: screenWidth < 500 ? 250 : 420,
                    onPageChanged: (index, reason) {
                      setState(() {
                        inIndex = index;
                      });
                    },
                    viewportFraction: 1,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ImageCount(
                      countImage: inIndex + 1,
                      height: 25,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ]),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.postModel!.title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
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
                    const Text(
                      'المعلومات',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                      ),
                      maxLines: 1,
                    ),
                    InformationPost(
                        section: 'القسم',
                        data:
                            "${widget.postModel!.category} - ${widget.postModel!.itemOrService}"),
                    InformationPost(
                        section: 'الموقع', data: widget.postModel!.location),
                    InformationPost(
                        section: 'الحالة', data: widget.postModel!.state),
                    InformationPost(
                        section: 'تاريخ النشر',
                        data: widget.postModel!.createAt.substring(0, 10)),
                    InformationPost(
                        section: 'العدد',
                        data: widget.postModel!.count.toString()),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'الوصف',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            )
                          ],
                          color: Colors.white),
                      child: Text(
                        widget.postModel!.description,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'حساب المتبرع',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              )
                            ],
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.postModel!.donarAccount,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                  ),
                                  const Icon(
                                    Icons.star_purple500_sharp,
                                    color: Colors.yellow,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 2),
                                        blurRadius: 6,
                                      )
                                    ],
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/image/user_image.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                          ],
                        )),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class InformationPost extends StatelessWidget {
  const InformationPost({
    this.section,
    this.data,
    super.key,
  });
  final String? data;
  final String? section;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6,
            )
          ],
          color: Colors.white),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Text(
              data ?? 'الاستهلاكيات - الطعام',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            )),
        Expanded(
            flex: 1,
            child: Text(
              section ?? 'القسم',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ))
      ]),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 122, 122, 122),
        radius: 15,
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class ImagePostComponent extends StatelessWidget {
  const ImagePostComponent({super.key, this.image});
  final String? image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: image!,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
