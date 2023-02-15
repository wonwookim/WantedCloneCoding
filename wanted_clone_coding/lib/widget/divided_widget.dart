import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/color.dart';

class DividedWidget extends StatelessWidget {
  DividedWidget({Key? key, this.height, this.thickness}) : super(key: key);

  double? height;
  double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 16,
      thickness: thickness ?? 10,
      color: AppColors.dividegray,
    );
  }
}
