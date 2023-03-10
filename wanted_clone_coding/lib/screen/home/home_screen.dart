import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/home_controller.dart';
import 'package:wanted_clone_coding/model/career_insight_model.dart';
import 'package:wanted_clone_coding/model/event_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/auto_change_widget.dart';
import 'package:wanted_clone_coding/widget/dialog_widget.dart';
import 'package:wanted_clone_coding/widget/divided_widget.dart';
import 'package:wanted_clone_coding/widget/info_image_widget.dart';
import 'package:wanted_clone_coding/widget/intro_widget.dart';
import 'package:wanted_clone_coding/widget/remove_scroll_effect_widget.dart';
import 'package:wanted_clone_coding/widget/tag_widget.dart';
import 'package:wanted_clone_coding/widget/tap_widget.dart';

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
                toolbarHeight:
                    controller.appBarTagIsTap.value ? 110 : kToolbarHeight,
                title: TapWidget(
            isTap: controller.appBarTagIsTap,
            tagList: controller.tagList,
            activeTag: controller.activeTag,
            changePage: controller.getCareerInsight(controller.tagList
                .where((p0) => p0.isTap.value == 1)
                .first
                .tagId)),
                titleSpacing: 0,
                elevation: 0,
                automaticallyImplyLeading: false,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(
                    height: 1,
                    color: AppColors.cardGray,
                  ),
                ),
              )
            : null,
        body: RemoveScrollEffect(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                            controller: controller.pController,
                            eventList: controller.eventList,
                            currentIndex: controller.currentIndex,
                          )),
                  ],
                ),
                if (controller.screenState.value == ScreenState.success)
                  Column(children: [
                    myCareerInsight(context),
                    const SizedBox(height: 24),
                    goTypeTest(context),
                    const SizedBox(height: 30),
                    wantedCreator(context),
                    const SizedBox(
                      height: 40,
                    ),
                    DividedWidget(height: 8),
                    const SizedBox(
                      height: 40,
                    ),
                    tagSetting(context),
                    const SizedBox(
                      height: 40,
                    ),
                    eventForCareerDevelopArea(context),
                    const SizedBox(
                      height: 40,
                    ),
                    DividedWidget(
                      height: 8,
                    )
                  ])
              ],
            ),
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
            children: [
              AppbarWidget(
                screen: Screen.home,
                screenState: controller.screenState,
              ),
              const Divider(
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
              Text('????????? ????????? ????????? ????????????',
                  style: MyTextTheme.size_18(context)
                      .copyWith(color: AppColors.mainblack)),
              const SizedBox(width: 4),
              GestureDetector(
                  onTap: () {
                    showOneButtonDialog(
                        title: "??????/?????? ?????????????????? ????????????? \u{1F60E}",
                        buttonFunction: () {
                          Get.back();
                        },
                        buttonText: '??????',
                        startContent:
                            '????????? ????????????, ?????? ?????? ?????? ??????\n??????????????? ???????????????!\n????????? IT?????? ??????????????? ????????? ???????????? ????????????\n????????? ???????????? ???????????? ?????? ?????? ???????????? ?????????\n????????????.');
                  },
                  child: SvgPicture.asset('assets/icons/information.svg'))
            ],
          ),
        ),
        SizedBox(height: 16, key: controller.gKey),
        TapWidget(
            isTap: controller.isTap,
            tagList: controller.tagList,
            activeTag: controller.activeTag,
            changePage: controller.getCareerInsight(controller.tagList
                .where((p0) => p0.isTap.value == 1)
                .first
                .tagId)),
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
          child: temptButton(
            context,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '??? ?????? ????????? ?????? ',
                  style: MyTextTheme.size_18(context)
                      .copyWith(fontSize: 16)
                      .copyWith(color: AppColors.mainblack),
                ),
                const Icon(Icons.refresh)
              ],
            ),
          ),
        ),
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

  // Widget tapWidget(context, RxBool isTap) {
  //   return Obx(
  //     () => Stack(
  //       children: [
  //         isTap.value
  //             ? Padding(
  //                 padding: const EdgeInsets.only(left: 16, right: 60),
  //                 child: Wrap(
  //                     clipBehavior: Clip.hardEdge,
  //                     spacing: 8,
  //                     runSpacing: 8,
  //                     children: controller.tagList
  //                         .map((element) => TagWidget(
  //                               ontap: () async {
  //                                 element.isTap.value = 1;
  //                                 controller.tagList
  //                                     .where((tag) =>
  //                                         tag.tagId ==
  //                                         controller.activeTag.value)
  //                                     .first
  //                                     .isTap
  //                                     .value = 0;
  //                                 await controller
  //                                     .getCareerInsight(element.tagId);
  //                                 controller.activeTag.value = element.tagId;
  //                               },
  //                               tag: element,
  //                               height: 35,
  //                             ))
  //                         .toList()),
  //               )
  //             : Padding(
  //                 padding: const EdgeInsets.only(right: 40.0),
  //                 child: SizedBox(
  //                   height: 35,
  //                   child: ListView.separated(
  //                     physics: const BouncingScrollPhysics(),
  //                     itemBuilder: (context, index) {
  //                       return TagWidget(
  //                         tag: controller.tagList[index],
  //                         ontap: () async {
  //                           controller.tagList
  //                               .where((p0) =>
  //                                   p0.tagId == controller.activeTag.value)
  //                               .first
  //                               .isTap
  //                               .value = 0;
  //                           controller.tagList[index].isTap.value = 1;
  //                           await controller.getCareerInsight(
  //                               controller.tagList[index].tagId);
  //                           controller.activeTag.value =
  //                               controller.tagList[index].tagId;
  //                         },
  //                       );
  //                     },
  //                     separatorBuilder: (context, index) {
  //                       return const SizedBox(
  //                         width: 8,
  //                       );
  //                     },
  //                     padding: const EdgeInsets.only(left: 16, right: 20),
  //                     itemCount: controller.tagList.length,
  //                     scrollDirection: Axis.horizontal,
  //                     shrinkWrap: true,
  //                     primary: false,
  //                   ),
  //                 ),
  //               ),
  //         Positioned(
  //           right: 16,
  //           child: GestureDetector(
  //             onTap: () {
  //               isTap.value = !isTap.value;
  //             },
  //             child: Container(
  //               width: 35,
  //               height: 35,
  //               decoration: BoxDecoration(
  //                   color: AppColors.mainWhite,
  //                   border: Border.all(color: AppColors.cardGray),
  //                   borderRadius: BorderRadius.circular(16),
  //                   boxShadow: isTap.value
  //                       ? null
  //                       : [
  //                           BoxShadow(
  //                               color: AppColors.mainWhite.withOpacity(0.7),
  //                               spreadRadius: 10,
  //                               blurRadius: 5.0,
  //                               offset: Offset(-3, 0))
  //                         ]),
  //               child: Center(
  //                 child: Text(
  //                   !isTap.value ? "???" : "???",
  //                   style: MyTextTheme.size_12_bold(context)
  //                       .copyWith(color: AppColors.textGray),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget goTypeTest(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InfoImageWidget(
        height: 80,
        width: Get.width,
        imgUrl: 'assets/icons/test/won_test_img.png',
        istemp: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '?????? ??? ?????? ??????????\n',
                      style: MyTextTheme.navigationTitle(context).copyWith(
                          fontSize: 16,
                          color: AppColors.mainWhite,
                          height: 1.5)),
                  TextSpan(
                      text: '??????????????? ????????????   >',
                      style: MyTextTheme.mainheight(context)
                          .copyWith(color: AppColors.mainWhite))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget wantedCreator(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InfoImageWidget(
          isborder: false,
          height: 180,
          width: Get.width,
          istemp: true,
          imgUrl: 'assets/icons/test/wanted_creator.png',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('????????? ???????????????',
                      style: MyTextTheme.size_22(context)
                          .copyWith(color: AppColors.mainblack, height: 1.5)),
                  const SizedBox(height: 4),
                  Text('?????? ??? ?????? ??????????????? ???\n????????? ??????????',
                      style: MyTextTheme.mainheight(context)
                          .copyWith(fontSize: 16)),
                  const SizedBox(height: 16),
                  temptButton(
                    context,
                    isborder: false,
                    color: AppColors.mainblue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '??????????????? ????????????   >',
                          style: MyTextTheme.size_18(context)
                              .copyWith(fontSize: 16)
                              .copyWith(color: AppColors.mainWhite),
                        ),
                      ],
                    ),
                  )
                ]),
          )),
    );
  }

  Widget tagSetting(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InfoImageWidget(
        height: 87,
        width: Get.width,
        imgUrl: 'assets/icons/test/interested_tag_color.png',
        istemp: true,
        isborder: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '?????? ????????? ????????????\n',
                      style: MyTextTheme.navigationTitle(context).copyWith(
                          fontSize: 16,
                          color: AppColors.mainWhite,
                          height: 1.5)),
                  TextSpan(
                      text: '????????? ?????? ???????????? ????????? ?????????. \u{1F389}',
                      style: MyTextTheme.navigationTitle(context).copyWith(
                          fontSize: 16,
                          color: AppColors.mainWhite,
                          height: 1.5))
                ]),
              ),
              const Spacer(),
              Text('>',
                  style: MyTextTheme.size_22(context).copyWith(
                      fontSize: 16, color: AppColors.mainWhite, height: 1.5))
            ],
          ),
        ),
      ),
    );
  }

  Widget eventForCareerDevelopArea(context) {
    return Column(
      children: [
        IntroWidget(
            title: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '????????? ????????? ??????\n?????? ?????????',
                    style: MyTextTheme.size_18(context)
                        .copyWith(color: AppColors.mainblack, height: 1.5))
              ]),
            ),
            moreView: '?????????'),
        const SizedBox(height: 16),
        SizedBox(
          height: 265,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemCount: controller.eventForDevelopList.length,
            itemBuilder: (context, index) {
              return eventForCareerDevelopItem(
                  context, controller.eventForDevelopList[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 8);
            },
          ),
        )
      ],
    );
  }

  Widget eventForCareerDevelopItem(context, Event event) {
    return SizedBox(
      width: 260,
      // height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InfoImageWidget(height: 150, width: 260, imgUrl: event.image),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: event.type!.color),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                event.type!.type,
                style: MyTextTheme.caption(context)
                    .copyWith(color: event.type!.color),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(event.title,
              style: MyTextTheme.mainbold(context)
                  .copyWith(color: AppColors.mainblack)),
          const SizedBox(height: 8),
          if (event.startDate != null)
            Text(
              '${event.startDate!.year}.${event.startDate!.month}.${event.startDate!.day} ~ ${event.endDate!.year}.${event.startDate!.month}.${event.startDate!.day}',
              style: MyTextTheme.size_12(context)
                  .copyWith(color: AppColors.textGray),
            ),
          Wrap(
            spacing: 4,
            children: event.tag!
                .map((e) => Text('#${e.tag}',
                    style: MyTextTheme.size_12(context)
                        .copyWith(color: AppColors.textGray, height: 1.5)))
                .toList(),
          )
        ],
      ),
    );
  }

//-------------------------------------------??????-----------------------------------------------------
  Widget temptButton(context,
      {Color? color, required Widget child, bool isborder = true}) {
    return Container(
        decoration: BoxDecoration(
            border: isborder ? Border.all(color: AppColors.dividegray) : null,
            borderRadius: BorderRadius.circular(32),
            color: color),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16), child: child));
  }
}
