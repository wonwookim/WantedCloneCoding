import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/color.dart';

class MyTextTheme {
  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(
      //Size22
      fontSize:22,
      fontWeight: FontWeight.w700,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    displayMedium: TextStyle(
      //Size18
      fontSize:18,
      fontWeight: FontWeight.w700,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    titleLarge: TextStyle(
      // title
      fontSize: 25,
      fontWeight: FontWeight.w500,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    titleMedium: TextStyle(
      // NavigationTitle
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    labelLarge: TextStyle(
      // mainbold
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    labelMedium: TextStyle(
      // main
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    bodyLarge: TextStyle(
      // mainboldheight
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    bodyMedium: TextStyle(
      // mainheight
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    bodySmall: TextStyle(
      // caption
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
    labelSmall: TextStyle(
      // tempfont
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: 'SUIT',
      color: AppColors.mainWhite
    ),
  );

  static TextStyle size_22(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge!;
  }
  static TextStyle size_18(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium!;
  }
  static TextStyle title(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle navigationTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!;
  }

  static TextStyle mainbold(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!;
  }

  static TextStyle main(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!;
  }

  static TextStyle mainboldheight(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  static TextStyle mainheight(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle caption(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }

  static TextStyle tempfont(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!;
  }
}