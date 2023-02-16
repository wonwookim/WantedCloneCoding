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
  RxList<Event> suggestList = <Event>[].obs;
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
    suggestList.value =
        suggest_position_json.map((e) => Event.fromJson(e)).toList();
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
      'image': 'https://cdn.imweb.me/thumbnail/20220604/63df980e50c50.png',
    },
    {
      'type': 'event',
      'title': '최근 100억 이상 투자 받은 기업',
      'subtitle': '채용 중 포지션 확인하기',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://contents.nextunicorn.kr/company/179b45c219945a65/rep-76e017d744e6279i5fc77199f3f55994cffa.png?s=640x&t=cover&f=jpg'
    },
    {
      'type': 'recruit',
      'title': "'100악 투자유치' XYZ",
      'subtitle': '로봇으로 바꾸는 일상, 함께 만들어요',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://cdn.imweb.me/upload/S202201267a1bf4b51a6a5/8b289e6b017e4.png'
    },
  ];

  List<Map<String, dynamic>> suggest_position_json = [
    {
      'title': '안드로이드 개발자',
      'subtitle': '피닉스다트',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'location': '서울 · 한국',
      'reward': 1000000,
      'image':
          'https://www.itworld.co.kr/files/itworld/2020/02/How%20to%20run%20Android%20apps%20in%20Windows-1.jpg',
    },
    {
      'title': '앱 개발',
      'subtitle': '한국투자증권',
      'location': '서울 · 한국',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'http://www.newsroad.co.kr/news/photo/202208/18229_19424_2032.png'
    },
    {
      'title': '안드로이드 개발자',
      'subtitle': '지란지교시큐리티',
      'location': '대전 · 한국',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://www.jiransecurity.com/data/images/24ac8f02-3d83-4f92-8119-3c743d9be3ed.png'
    },
  ];
  List<Map<String, dynamic>> popular_position_json = [
    {
      'title': 'CS / CX 매니저',
      'subtitle': '버드코리아',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'location': '서울 · 한국',
      'reward': 1000000,
      'image':
          'https://static.wanted.co.kr/images/company/23597/xkkgdj0zuhuv1auw__1080_790.jpg',
    },
    {
      'title': '백엔드_Django 개발 주니어 (1년 이상)',
      'subtitle': '인플루디오',
      'location': '서울 · 한국',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://compphoto.incruit.com/2023/01/%EC%9B%90%ED%8B%B0%EB%93%9C%2020.jpg'
    },
    {
      'title': 'Backend Developer',
      'subtitle': '포스트랩',
      'location': '서울 · 한국',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://static.wanted.co.kr/images/company/35924/gfgua8so8rbskvba__1080_790.jpg'
    },
  ];
}
