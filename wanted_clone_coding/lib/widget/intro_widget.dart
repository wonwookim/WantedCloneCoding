import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class IntroWidget extends StatelessWidget {
  IntroWidget({Key? key, required this.textSpan, required this.moreView}) : super(key: key);
  List<InlineSpan>? textSpan;
  String moreView;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        RichText(text: TextSpan(children: textSpan)),
        const Spacer(),
        Text(moreView, style: MyTextTheme.mainbold(context).copyWith(color: AppColors.textGray),)
      ]),
    );
  }
}
