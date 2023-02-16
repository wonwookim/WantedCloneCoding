import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class IntroWidget extends StatelessWidget {
  IntroWidget({Key? key, required this.title, required this.moreView}) : super(key: key);
  Widget title;
  String moreView;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        title,
        const Spacer(),
        Text(moreView, style: MyTextTheme.mainbold(context).copyWith(color: AppColors.moreGray),)
      ]),
    );
  }
}
