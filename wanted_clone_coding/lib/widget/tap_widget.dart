import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/model/tag_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/tag_widget.dart';

class TapWidget extends StatelessWidget {
  TapWidget(
      {Key? key,
      required this.isTap,
      required this.tagList,
      required this.activeTag,
      required this.changePage})
      : super(key: key);
  RxBool isTap;
  RxList<Tag> tagList;
  RxInt activeTag;
  Future<void> changePage;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          isTap.value
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 60),
                  child: Wrap(
                      clipBehavior: Clip.hardEdge,
                      spacing: 8,
                      runSpacing: 8,
                      children: tagList
                          .map((element) => TagWidget(
                                ontap: () async {
                                  element.isTap.value = 1;
                                  tagList
                                      .where(
                                          (tag) => tag.tagId == activeTag.value)
                                      .first
                                      .isTap
                                      .value = 0;
                                  await changePage;
                                  // await controller
                                  //     .getCareerInsight(element.tagId);
                                  activeTag.value = element.tagId;
                                },
                                tag: element,
                                height: 35,
                              ))
                          .toList()),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: SizedBox(
                    height: 35,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TagWidget(
                          tag: tagList[index],
                          ontap: () async {
                            tagList
                                .where((p0) => p0.tagId == activeTag.value)
                                .first
                                .isTap
                                .value = 0;
                            tagList[index].isTap.value = 1;
                            await changePage;
                            // await controller.getCareerInsight(
                            //     tagList[index].tagId);
                            activeTag.value = tagList[index].tagId;
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      itemCount: tagList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      primary: false,
                    ),
                  ),
                ),
          Positioned(
            right: 16,
            child: GestureDetector(
              onTap: () {
                isTap.value = !isTap.value;
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    border: Border.all(color: AppColors.cardGray),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isTap.value
                        ? null
                        : [
                            BoxShadow(
                                color: AppColors.mainWhite.withOpacity(0.7),
                                spreadRadius: 10,
                                blurRadius: 5.0,
                                offset: Offset(-3, 0))
                          ]),
                child: Center(
                  child: Text(
                    !isTap.value ? "∨" : "∧",
                    style: MyTextTheme.size_12_bold(context)
                        .copyWith(color: AppColors.textGray),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
