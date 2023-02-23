import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/divided_widget.dart';

class AppbarWidget extends StatelessWidget {
  AppbarWidget(
      {Key? key,
      required this.screen,
      required this.screenState,
      this.actions,
      this.leading,
      this.bottom})
      : super(key: key);
  Screen screen;
  Rx<ScreenState> screenState;
  List<Widget>? actions;
  Widget? leading;
  PreferredSize? bottom;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return (screen == Screen.home || screen == Screen.employment)
        ? Padding(
            padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  // Image.asset('assets/icons/wanted_logo.png',height: 32, width: 90),
                  Text('wanted',
                      style: MyTextTheme.size_12_bold(context)
                          .copyWith(color: AppColors.mainWhite, fontSize: 25)),
                  const Spacer(),
                  SvgPicture.asset('assets/icons/search.svg'),
                  if (screen == Screen.home &&
                      screenState.value == ScreenState.success)
                    Row(children: [
                      const SizedBox(width: 20),
                      SvgPicture.asset('assets/icons/alarm.svg'),
                      const SizedBox(width: 20),
                      Image.asset(
                        'assets/icons/default_profile.png',
                        height: 32,
                        width: 32,
                      )
                    ])
                ],
              ),
            ),
          )
        : AppBar(
            leading: leading,
            actions: actions,
            title: Text(screen.name,
                style: MyTextTheme.mainbold(context).copyWith(fontSize: 16)),
            centerTitle: true,
            elevation: 0,
            bottom: bottom,
          );
  }
}
