import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/home_controller.dart';
import 'package:wanted_clone_coding/model/career_insight_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/auto_change_widget.dart';
import 'package:wanted_clone_coding/widget/dialog_widget.dart';
import 'package:wanted_clone_coding/widget/info_image_widget.dart';
import 'package:wanted_clone_coding/widget/tag_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  GlobalKey key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Obx(
      () => Scaffold(
        appBar: controller.appbarActive.value
            ? AppBar(
              toolbarHeight: controller.appBarTagIsTap.value ? 110 : kToolbarHeight,
                title: tapWidget(controller.appBarTagIsTap),
                titleSpacing: 0,
                elevation: 0,
                automaticallyImplyLeading: false,
                bottom: const PreferredSize(preferredSize: Size.fromHeight(1), child: Divider(height: 1, color: AppColors.cardGray,),),
              )
            : null,
        body: SingleChildScrollView(
          controller: controller.sController,
          child: Column(
            children: [
              Stack(
                children: [
                  change_color_area(),
                  if (controller.screenState.value == ScreenState.success)
                    Positioned(
                        top: statusBarHeight + kToolbarHeight + 20,
                        child: AutoChangeWidget(
                          categoryText: 'EVENT',
                          controller: controller.pController,
                          eventList: controller.eventList,
                          currentIndex: controller.currentIndex,
                        )),
                ],
              ),
              if (controller.screenState.value == ScreenState.success)
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
        SizedBox(height: 16, key: controller.gKey),
        tapWidget(controller.isTap),
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
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 16),
              itemBuilder: (context, index) {
                return Obx(() => careerInsightInfo(context, index));
              }),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: temptButton(context),
        ),
        const SizedBox(height: 24,)
      ],
    );
  }

  Widget careerInsightInfo(context, int index) {
    CareerInsight careerInsight =
        controller.careerInsightField[controller.activeTag.value]![index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoImageWidget(
            height: 110, width: Get.width, imgUrl: careerInsight.mainImg),
        const SizedBox(height: 16),
        Text(
          careerInsight.title,
          style: MyTextTheme.mainbold(context),
          maxLines: 2,
        ),
        const SizedBox(height: 4),
        Text(careerInsight.body,
            maxLines: 2,
            style: MyTextTheme.caption(context)
                .copyWith(color: AppColors.maingray)),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cardGray),
                  borderRadius: BorderRadius.circular(16)),
              child: careerInsight.profileImg != ''
                  ? CachedNetworkImage(imageUrl: careerInsight.profileImg)
                  : Image.asset('assets/icons/default_profile.png'),
            ),
            const SizedBox(width: 4),
            Text(careerInsight.name,
                style: MyTextTheme.caption(context).copyWith(
                  color: AppColors.maingray,
                ))
          ],
        )
      ],
    );
  }

  Widget tapWidget(RxBool isTap) {
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
                      children: controller.tagList
                          .map((element) => TagWidget(
                                ontap: () async {
                                  element.isTap.value = 1;
                                  controller.tagList
                                      .where((tag) =>
                                          tag.tagId ==
                                          controller.activeTag.value)
                                      .first
                                      .isTap
                                      .value = 0;
                                  await controller
                                      .getCareerInsight(element.tagId);
                                  controller.activeTag.value = element.tagId;
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
                          tag: controller.tagList[index],
                          ontap: () async {
                            controller.tagList
                                .where((p0) =>
                                    p0.tagId == controller.activeTag.value)
                                .first
                                .isTap
                                .value = 0;
                            controller.tagList[index].isTap.value = 1;
                            await controller.getCareerInsight(
                                controller.tagList[index].tagId);
                            controller.activeTag.value =
                                controller.tagList[index].tagId;
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      itemCount: controller.tagList.length,
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
                    border: Border.all(color: AppColors.dividegray),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: controller.isTap.value
                        ? null
                        : [
                            BoxShadow(
                                color: AppColors.mainWhite.withOpacity(0.7),
                                spreadRadius: 10,
                                blurRadius: 5.0,
                                offset: Offset(-3, 0))
                          ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget temptButton(context){
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.dividegray), borderRadius: BorderRadius.circular(32),),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('더 많은 콘텐츠 보기 ', style: MyTextTheme.navigationTitle(context).copyWith(fontSize: 16)
                        .copyWith(color: AppColors.mainblack),),
            Icon(Icons.refresh)
          ],
        ),
      )
    );
  }
}
