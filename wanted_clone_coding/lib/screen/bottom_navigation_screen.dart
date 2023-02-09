import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/bottom_navigation_controller.dart';
import 'package:wanted_clone_coding/screen/community/community_screen.dart';
import 'package:wanted_clone_coding/screen/employment/employment_screen.dart';
import 'package:wanted_clone_coding/screen/home/home_screen.dart';
import 'package:wanted_clone_coding/screen/my_info/my_info_screen.dart';
import 'package:wanted_clone_coding/screen/my_wanted/my_wanted_screen.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({Key? key}) : super(key: key);
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = [
      HomeScreen(),
      EmploymentScreen(),
      CommunityScreen(),
      MyInfoScreen(),
      MyWantedScreen()
    ];
    return Scaffold(
      extendBody: false,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: screen,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: Platform.isAndroid ? 56 : 48,
          child: BottomNavigationBar(
              selectedFontSize: 0,
              unselectedFontSize: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currentIndex.value,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              enableFeedback: false,
              backgroundColor: AppColors.popupGray,
              elevation: 0,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(icon: Text('홈'), label: '홈'),
                BottomNavigationBarItem(icon: Text('채용'), label: '채용'),
                BottomNavigationBarItem(icon: Text('커뮤니티'), label: '커뮤니티'),
                BottomNavigationBarItem(icon: Text('내 정보'), label: '내 정보'),
                BottomNavigationBarItem(icon: Text('MY 원티드'), label: 'MY 원티드')
              ]),
        ),
      ),
    );
  }
}
