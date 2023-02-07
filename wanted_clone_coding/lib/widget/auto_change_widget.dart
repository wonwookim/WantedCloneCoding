import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wanted_clone_coding/model/event_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class AutoChangeWidget extends StatelessWidget {
  //홈, 채용 탭에서 사용
  AutoChangeWidget(
      {Key? key,
      required this.categoryText,
      required this.controller,
      required this.eventList,
      required this.currentIndex})
      : super(key: key);
  String categoryText;
  PageController controller;
  List<Event> eventList;
  RxInt currentIndex;
  @override
  Widget build(BuildContext context) {
    currentIndex = currentIndex;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          category(context,categoryText: categoryText),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              eventList[currentIndex.value].title,
              style: MyTextTheme.size_18(context)
                  .copyWith(color: AppColors.mainWhite),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                eventList[currentIndex.value].subtitle,
                style: MyTextTheme.main(context)
                    .copyWith(color: AppColors.mainWhite),
              )),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            width: Get.width,
            child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  currentIndex.value = index % eventList.length;
                },
                itemBuilder: (context, index) {
                  int compIndex = index % eventList.length;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 120,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: eventList[compIndex].image,
                      errorWidget: (context, string, extra) {
                        return Container(
                          color: AppColors.maingray,
                        );
                      },
                      fit: BoxFit.fill,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget category(BuildContext context, {required String categoryText}) {
    return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.mainWhite,
              borderRadius: BorderRadius.circular(4)),
          height: 20,
          width: 60,
          child: Center(
            child: Text(
              categoryText,
              style: MyTextTheme.caption(context)
                  .copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ));
  }
}
