import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {Key? key,
      required this.onTap,
      required this.btnColor,
      required this.btnText,
      this.textColor,
      this.fontSize,
      required this.height,
      required this.width,
      // this.isBorder,
      this.borderColor})
      : super(key: key);

  String btnText;
  Color btnColor;
  VoidCallback onTap;
  Color? borderColor;
  Color? textColor;
  double? fontSize;
  // bool? isBorder;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(btnText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                  )),
            ),
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                border: Border.all(color: borderColor ?? Colors.transparent))));
  }
}
