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
          'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbRQgj4%2Fbtq3n9auUMk%2Fx1jFjVPF3vwrv7dWJZmLok%2Fimg.png',
    },
    {
      'type': 'event',
      'title': '최근 100억 이상 투자 받은 기업',
      'subtitle': '채용 중 포지션 확인하기',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image': 'https://static.wanted.co.kr/images/events/2680/11ae45d0.jpg'
    },
    {
      'type': 'recruit',
      'title': "'100악 투자유치' XYZ",
      'subtitle': '로봇으로 바꾸는 일상, 함께 만들어요',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image': 'https://static.wanted.co.kr/images/events/1797/dac1b4f4.jpg'
    },
  ];
}
