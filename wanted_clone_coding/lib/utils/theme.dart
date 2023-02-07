import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class MyTheme {
  static final lightTheme = ThemeData(
      fontFamily: 'SUIT',
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.mainWhite,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),

        backgroundColor: AppColors.mainWhite,
        // foregroundColor: mainblack,
      ),
      canvasColor: AppColors.mainWhite,
      textTheme: MyTextTheme.textTheme.apply(bodyColor: AppColors.mainblack),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.mainblue),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.mainblack,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      scrollbarTheme: ScrollbarThemeData(
          thickness: MaterialStateProperty.all(5),
          thumbColor: MaterialStateProperty.all(AppColors.maingray),
          radius: const Radius.circular(10)));
}
