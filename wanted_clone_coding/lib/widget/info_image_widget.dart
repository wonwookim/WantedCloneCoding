import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:wanted_clone_coding/utils/color.dart';

class InfoImageWidget extends StatelessWidget {
  InfoImageWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.imgUrl})
      : super(key: key);
  double height;
  double width;
  String imgUrl;
  @override
  Widget build(BuildContext context) {
    return imgUrl == ""
        ? imageWidget(Image.asset(
            'assets/icons/default_image.png',
          ).image)
        : CachedNetworkImage(
            imageUrl: imgUrl,
            imageBuilder: (context, imageProvider) {
              return imageWidget(imageProvider);
            },
          );
  }

  Widget imageWidget(ImageProvider<Object> image) {
    return Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividegray),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: image, fit: BoxFit.fill)));
  }
}
