import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:underline_indicator/underline_indicator.dart';

class TabBarWidget extends StatelessWidget {
  TabBarWidget(
      {Key? key,
      required this.tabController,
      required this.tabs,
      this.isDark = false})
      : super(key: key);

  TabController tabController;
  List<Widget> tabs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.mainblack, width: 2.0),
                ),
              ),
            ),
            TabBar(
                controller: tabController,
                labelStyle: MyTextTheme.mainbold(context),
                labelColor: AppColors.mainblue,
                unselectedLabelStyle: MyTextTheme.main(context),
                unselectedLabelColor: AppColors.mainblack,
                automaticIndicatorColorAdjustment: false,
                indicator: UnderlineIndicator(
                  strokeCap: StrokeCap.round,
                  borderSide: BorderSide(width: 2, color: AppColors.mainblue),
                ),
                isScrollable: false,
                tabs: tabs),
          ],
        ),
      ],
    );
  }
}
