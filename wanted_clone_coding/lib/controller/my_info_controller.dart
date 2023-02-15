import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInfoController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static MyInfoController get to => Get.find();

  late TabController tabController;
  // RxInt currentIndex = 0.obs;

  @override
  void onInit() async {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.onInit();
  }
}
