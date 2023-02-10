import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:wanted_clone_coding/utils/color.dart';

class InfoImageWidget extends StatelessWidget {
  InfoImageWidget({Key? key, required this.height, required this.width, required this.imgUrl}) : super(key: key);
  double height;
  double width;
  String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
                      height: height,
                      width: width,
                      clipBehavior: Clip.hardEdge,
                      decoration:
                          BoxDecoration(border: Border.all(color: AppColors.dividegray),borderRadius: BorderRadius.circular(8)),
                      child: imgUrl == '' ? Image.asset('assets/icons/default_image.png', fit: BoxFit.fill,) : CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              imgUrl),
                    );
  }
}