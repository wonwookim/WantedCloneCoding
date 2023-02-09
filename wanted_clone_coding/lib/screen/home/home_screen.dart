import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/home_controller.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/auto_change_widget.dart';
import 'package:wanted_clone_coding/widget/dialog_widget.dart';
import 'package:wanted_clone_coding/widget/tag_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  change_color_area(),
                  Positioned(
                      top: statusBarHeight + kToolbarHeight + 20,
                      child: AutoChangeWidget(
                        categoryText: 'EVENT',
                        controller: controller.pController,
                        eventList: controller.eventList,
                        currentIndex: controller.currentIndex,
                      ))
                ],
              ),
              myCareerInsight(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget change_color_area() {
    return Column(children: [
      Obx(
        () => Container(
          decoration: BoxDecoration(
              color: controller.colors.isNotEmpty
                  ? controller.colors[controller.currentIndex.value].color
                  : AppColors.mainblue),
          height: 300,
          child: Column(
            children: const [
              AppbarWidget(),
              Divider(
                height: 1,
                color: AppColors.maingray,
              )
            ],
          ),
        ),
      ),
      const SizedBox(height: 70),
    ]);
  }

  Widget myCareerInsight(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('나에게 필요한 커리어 인사이트',
                  style: MyTextTheme.size_18(context)
                      .copyWith(color: AppColors.mainblack)),
              const SizedBox(width: 4),
              GestureDetector(
                  onTap: () {
                    showOneButtonDialog(
                        title: "취직/이직 준비하시기도 바쁘시죠? \u{1F60E}",
                        buttonFunction: () {
                          Get.back();
                        },
                        buttonText: '확인',
                        startContent:
                            '커리어 인사이트, 이제 따로 찾지 말고\n원티드에서 만나보세요!\n검증된 IT업계 전문가들이 다양한 채널에서 생산하는\n커리어 콘텐츠를 선별해서 관심 태그 기반으로 제공해\n드립니다.');
                  },
                  child: SvgPicture.asset('assets/icons/information.svg'))
            ],
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: SizedBox(
                  height: 35,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.tagList
                                .where((p0) =>
                                    p0.tagId == controller.activeTag.value)
                                .first
                                .isTap
                                .value = 0;
                            controller.tagList[index].isTap.value = 1;
                            controller.activeTag.value =
                                controller.tagList[index].tagId;
                          },
                          child: TagWidget(tag: controller.tagList[index]));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    padding: EdgeInsets.zero,
                    itemCount: controller.tagList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                  ),
                ),
              ),
              Positioned(
                right: 16,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: AppColors.mainWhite,
                      border: Border.all(color: AppColors.dividegray),
                      borderRadius: BorderRadius.circular(16)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 16),
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(color: AppColors.mainblack));
              }),
        )
      ],
    );
  }
}
