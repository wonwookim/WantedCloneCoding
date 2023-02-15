import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/bottom_navigation_controller.dart';
import 'package:wanted_clone_coding/main.dart';
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
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: screen,
        ),
      ),
      bottomNavigationBar: Obx(
        () => SafeArea(
          child: Container(
            height: 56,
            child: BottomNavigationBar(
                backgroundColor: AppColors.naviColor,
                elevation: 0,
                unselectedLabelStyle: MyTextTheme.main(context).copyWith(fontSize: 10, color: AppColors.mainblack),
                unselectedItemColor: AppColors.mainblack,
                unselectedFontSize: 10,
                selectedLabelStyle: MyTextTheme.main(context).copyWith(fontSize: 10, color: AppColors.mainblack),
                selectedItemColor: AppColors.mainblack,
                selectedFontSize: 10,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeBottomNav,
                items: [
                  BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/home_inactive.svg'),activeIcon: SvgPicture.asset('assets/icons/home_active.svg'), label: '홈'),
                  BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/recruit_inactive.svg'),activeIcon: SvgPicture.asset('assets/icons/recruit_active.svg'), label: '채용'),
                  BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/community_inactive.svg'),activeIcon: SvgPicture.asset('assets/icons/community_active.svg'), label: '커뮤니티'),
                  BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/my_info_inactive.svg'),activeIcon: SvgPicture.asset('assets/icons/my_info_active.svg'), label: '내 정보'),
                  BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/my_wanted_inactive.svg'),activeIcon: SvgPicture.asset('assets/icons/my_wanted_active.svg'), label: 'MY 원티드')
                ]),
          ),
        ),
      ),
    );
  }
}
