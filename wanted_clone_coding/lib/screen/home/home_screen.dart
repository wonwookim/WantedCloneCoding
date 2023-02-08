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

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Column(
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
              AppbarWidget(),
              Divider(
                height: 1,
                color: AppColors.maingray,
              )
            ],
          ),
        ),
      ),
      SizedBox(height: 70),
    ]);
  }

  Widget fixed_color_area() {
    return Container();
  }

  Widget myCareerInsight(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text('나에게 필요한 커리어 인사이트',
                  style: MyTextTheme.size_18(context)
                      .copyWith(color: AppColors.mainblack)),
              const SizedBox(width: 4),
              GestureDetector(
                  onTap: () {showOneButtonDialog(title: '취직/이직 준비하시기도 바쁘시죠?', buttonFunction: () {}, buttonText: '확인', startContent: '커리어 인사이트, 이제 따로 찾지 말고');},
                  child: SvgPicture.asset('assets/icons/information.svg'))
            ],
          )
        ],
      ),
    );
  }
}
