import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/model/tag_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class TagWidget extends StatelessWidget {
  TagWidget({Key? key, required this.tag, this.height, this.width})
      : super(key: key);
  Tag tag;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: tag.isTap.value == 0 ?AppColors.dividegray : AppColors.mainblue)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Text(
              tag.tag,
              style: MyTextTheme.size_12_bold(context)
                  .copyWith(color: tag.isTap.value == 0 ?AppColors.maingray : AppColors.mainblue),
            ),
          ),
        ),
      ),
    );
  }
}
