import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';

class AppbarWidget extends StatelessWidget  {
  AppbarWidget({Key? key, required this.screen,required this.screenState}) : super(key: key);
  Screen screen;
  Rx<ScreenState> screenState;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight, left: 16,right: 16),
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(children: [
          Image.asset('assets/icons/wanted_logo.png',height: 32, width: 90),
          const Spacer(),
          SvgPicture.asset('assets/icons/search_inactive.svg'),
          if(screen == Screen.home && screenState.value == ScreenState.success)
          Row(children: [
          SizedBox(width: 20),
          SvgPicture.asset('assets/icons/alarm_inactive.svg'),
          SizedBox(width: 20),
          Image.asset('assets/icons/default_profile.png', height: 32, width: 32,)
          ])
        ],),
      ),
    );
  }
}
