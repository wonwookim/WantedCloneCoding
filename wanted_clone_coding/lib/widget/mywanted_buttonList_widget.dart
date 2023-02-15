import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/button_widget.dart';
import 'package:wanted_clone_coding/widget/divided_widget.dart';

class ButtonListWidget extends StatelessWidget {
  ButtonListWidget({
    Key? key,
    required this.title,
    required this.explain,
    required this.btnText,
    required this.onTap,
  }) : super(key: key);

  String title;
  String explain;
  String btnText;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DividedWidget(
          height: 1,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(title,
                textAlign: TextAlign.start,
                style: MyTextTheme.mainboldheight(context)
                    .copyWith(fontSize: 15))),
        Center(
          child: Text(
            explain,
            style: MyTextTheme.main(context)
                .copyWith(fontSize: 13, color: Color.fromARGB(255, 92, 92, 92)),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                child: Text(btnText,
                    style: MyTextTheme.mainboldheight(context)
                        .copyWith(color: AppColors.mainblue, fontSize: 14)),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.mainblue, width: 1.0)),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
