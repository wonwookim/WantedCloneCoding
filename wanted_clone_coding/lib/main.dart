import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/screen/bottom_navigation_screen.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.lightTheme,
      home: BottomNavigationScreen(),
      debugShowCheckedModeBanner:false
    );
  }
}
