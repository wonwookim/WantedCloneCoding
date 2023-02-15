import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/employment_controller.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/auto_change_widget.dart';
import 'package:wanted_clone_coding/widget/intro_widget.dart';
import 'package:wanted_clone_coding/widget/remove_scroll_effect_widget.dart';

class EmploymentScreen extends StatelessWidget {
  EmploymentScreen({Key? key}) : super(key: key);
  EmploymentController controller = Get.put(EmploymentController());
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Obx(
      () => Scaffold(
        body: RemoveScrollEffect(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                            eventList: controller.recruitList,
                            currentIndex: controller.currentIndex,
                          )),
                  ],
                ),
                if (controller.screenState.value == ScreenState.success)
                  Column(children: [
                    gotoRecruitPosition(context),
                    const SizedBox(height: 40),
                    recentViewPosition(context)
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
          height: 275,
          child: Column(
            children: [
              AppbarWidget(
                screen: Screen.employment,
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

  Widget gotoRecruitPosition(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF4AA4F7),
              AppColors.mainblue,
              Color(0xFF4AA4F7)
            ], stops: [
              0.1,
              0.5,
              0.9
            ]),
            borderRadius: BorderRadius.circular(32)),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/search.svg',
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 12,
            ),
            Text('채용 중인 포지션 보러 가기',
                style: MyTextTheme.mainbold(context)
                    .copyWith(color: AppColors.mainWhite))
          ],
        ),
      ),
    );
  }

  Widget recentViewPosition(context) {
    return Column(
      children: [
        IntroWidget(textSpan: [
          TextSpan(
              text: '최근 본 포지션',
              style: MyTextTheme.size_12_bold(context)
                  .copyWith(fontSize: 17, color: AppColors.mainblack))
        ], moreView: '전체보기'),
        const SizedBox(height: 20),
        
      ],
    );
  }
}
