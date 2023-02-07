import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum RouteName {
  home,
  employment,
  community,
  myinfo,
  mywanted,
}

class BottomNavigationController extends GetxController{
  RxInt currentIndex = 0.obs;
  void changeBottomNav(int index){
    currentIndex.value = index;
  }
}
