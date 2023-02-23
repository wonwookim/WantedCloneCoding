import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/model/tag_model.dart';
import 'package:wanted_clone_coding/utils/constant.dart';

class CommunityController extends GetxController{
  Rx<ScreenState> screenState = ScreenState.normal.obs;
  
  RxList<Tag> tagList = <Tag>[].obs;

  RxInt activeTag = 0.obs;

  RxBool isTap = false.obs;


  @override
  void onInit()async{
    await getTag();
    super.onInit();
  }




  Future<void> getTag() async {
    tagList.value = tag_json.map((e) => Tag.fromJson(e)).toList();
    tagList.first.isTap.value = 1;
    activeTag.value = tagList.first.tagId;
  }
}