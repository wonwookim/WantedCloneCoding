import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/home_controller.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/auto_change_widget.dart';

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
      SizedBox(height: 100),
    ]);
  }

  Widget fixed_color_area() {
    return Container();
  }
}
