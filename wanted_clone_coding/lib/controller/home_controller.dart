import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wanted_clone_coding/model/tag_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';

import '../model/event_model.dart';

class HomeController extends GetxController {
  late PageController pController;
  Timer? timer;
  RxList<PaletteColor> colors = <PaletteColor>[].obs;
  RxInt currentIndex = 0.obs;
  //-----------tag-----------------------
  RxList<Tag> tagList = <Tag>[].obs;
  RxInt activeTag = 0.obs;
  //-----------------------------------
  @override
  void onInit() async {
    pController = PageController(
        viewportFraction: 0.9, initialPage: eventList.length * 100);
    getTag();
    timerstart();
    await getPalettes();
    pController.addListener(() {
      if (timer != null) {
        timer!.cancel();
        timerstart();
      }
    });
    super.onInit();
  }

  Future getPalettes() async {
    List<String> images = eventList.map((e) => e.image).toList();
    await _updatePalettes(images);
    print(colors);
  }

  void timerstart() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      pController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  Future _updatePalettes(List<String> images) async {
    List<PaletteColor> tempColors = [];
    for (String image in images) {
      try {
        final PaletteGenerator generator =
            await PaletteGenerator.fromImageProvider(
          NetworkImage(image),
          size: const Size(200, 120),
        );
        tempColors.add(generator.darkMutedColor ??
            generator.darkVibrantColor ??
            PaletteColor(AppColors.mainWhite, 2));
      } catch (e) {
        tempColors.add(PaletteColor(AppColors.mainblue, 2));
      }
    }
    colors(tempColors);
  }

  void getTag() {
    tagList.value = tag_json.map((e) => Tag.fromJson(e)).toList();
    tagList.first.isTap.value = 1;
    activeTag.value = tagList.first.tagId;
  }

// ------------------------------------DUMMY DATA --------------------------------------------------------------------
  List<Event> eventList = [
    Event(
        title: '우리 회사를 소개합니다.',
        subtitle: '회사에 대한 정보, 원티드가 찾아드릴게요',
        image:
            'https://loopusimage.s3.ap-northeast-2.amazonaws.com/post/image/20220823/2022-08-23T225601.553691_44_0_aspectRatio1.000.jpg'),
    Event(
        title: '2022 개발자 리포트',
        subtitle: '지금 무료로 다운받으세요!',
        image:
            'https://loopusimage.s3.ap-northeast-2.amazonaws.com/profile_image/image_crop_3a8b995e-b61c-4b5a-926c-6c7f5366dd1f489681898.jpg'),
    Event(
        title: '원티드 매거진 & Workers',
        subtitle: '무료 다운로드하고 경품도 받으세요!',
        image:
            'https://loopusimage.s3.ap-northeast-2.amazonaws.com/profile_image/image_cropper_1645676938168.jpg'),
  ];

  List<Map<String, dynamic>> tag_json = [
    {'tag_id': 0, 'tag': 'IT/기술'},
    {'tag_id': 1, 'tag': '개발'},
    {'tag_id': 2, 'tag': '커리어고민'},
    {'tag_id': 3, 'tag': '취업/이직'},
    {'tag_id': 4, 'tag': '데이터'},
    {'tag_id': 5, 'tag': '회사생활'},
    {'tag_id': 6, 'tag': 'HR'},
    {'tag_id': 7, 'tag': '마케팅'}
  ];
}
