import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wanted_clone_coding/model/event_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';

class EmploymentController extends GetxController {
  late PageController pController;
  Rx<ScreenState> screenState = ScreenState.normal.obs;
  RxInt currentIndex = 0.obs;
  Timer? timer;

  //--------palette color---------------
  RxList<PaletteColor> colors = <PaletteColor>[].obs;

  //--------eventList---------------------
  RxList<Event> recruitList = <Event>[].obs;

  @override
  void onInit() async {
    await getEventList();
    await getPalettes();
    screenState(ScreenState.success);
    timerstart();
    pController = PageController(
        viewportFraction: 0.9, initialPage: recruitList.length * 100);
    pController.addListener(() {
      if (timer != null) {
        timer!.cancel();
        timerstart();
      }
    });
    super.onInit();
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

  //------------팔레트 색 구하기 ------------------
  Future getPalettes() async {
    List<String> images = recruitList.map((e) => e.image).toList();
    await _updatePalettes(images);
  }

  void timerstart() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      pController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

//------------------------------------Get event --------------------------------------------------------------------------------
  Future<void> getEventList() async {
    recruitList.value = recruit_json.map((e) => Event.fromJson(e)).toList();
  }

  //-------------------------dummy data-----------------------------
  List<Map<String, dynamic>> recruit_json = [
    {
      'type': 'recruit',
      'title': '스마트 체형분석 솔루션, 피트릭스',
      'subtitle': '엔지니어 채용 중',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://cdn.imweb.me/thumbnail/20220604/63df980e50c50.png',
    },
    {
      'type': 'event',
      'title': '최근 100억 이상 투자 받은 기업',
      'subtitle': '채용 중 포지션 확인하기',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image': 'https://contents.nextunicorn.kr/company/179b45c219945a65/rep-76e017d744e6279i5fc77199f3f55994cffa.png?s=640x&t=cover&f=jpg'
    },
    {
      'type': 'recruit',
      'title': "'100악 투자유치' XYZ",
      'subtitle': '로봇으로 바꾸는 일상, 함께 만들어요',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image': 'https://cdn.imweb.me/upload/S202201267a1bf4b51a6a5/8b289e6b017e4.png'
    },
  ];
}
