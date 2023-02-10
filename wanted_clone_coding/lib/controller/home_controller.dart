import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wanted_clone_coding/model/career_insight_model.dart';
import 'package:wanted_clone_coding/model/tag_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';

import '../model/event_model.dart';

class HomeController extends GetxController {
  late PageController pController;
  Timer? timer;
  Rx<ScreenState> screenState = ScreenState.normal.obs;
  RxList<PaletteColor> colors = <PaletteColor>[].obs;
  RxInt currentIndex = 0.obs;
  //-----------tag-----------------------
  RxList<Tag> tagList = <Tag>[].obs;
  RxInt activeTag = 0.obs;
  //-----------------------------------
  RxMap<int, List<CareerInsight>> careerInsightField =
      <int, List<CareerInsight>>{}.obs;

  @override
  void onInit() async {
    pController = PageController(
        viewportFraction: 0.9, initialPage: eventList.length * 100);
    await getTag().then((value) => getCareerInsight(activeTag.value));

    await getPalettes();
    screenState(ScreenState.success);
    timerstart();
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

  Future<void> getTag() async {
    tagList.value = tag_json.map((e) => Tag.fromJson(e)).toList();
    tagList.first.isTap.value = 1;
    activeTag.value = tagList.first.tagId;
  }

  Future<void> getCareerInsight(int activeTag) async {
    if (!careerInsightField.containsKey(activeTag)) {
      careerInsightField[activeTag] = career_insight_json[activeTag]!
          .map((careerInsight) => CareerInsight.fromJson(careerInsight))
          .toList();
    }
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

  Map<int, List<Map<String, dynamic>>> career_insight_json = {
    0: [
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
        'main_img':
            'https://loopusimage.s3.ap-northeast-2.amazonaws.com/profile_image/image_cropper_1645676938168.jpg',
        'profile_img': ''
      },
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
    ],
    1: [
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
      },
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
    ],
    2: [
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
      },
    ],
    3: [
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
      },
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
    ],
    4: [
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
    ],
    5: [
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
      },
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
    ],
    6: [
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
    ],
    7: [
      {
        'title': '예시 사례를 살펴보는 실제 이력서 작성법 - 백승엽',
        'body': '오늘은 실제 예시를 통해 이력서를 작성하는 방법에 대해...',
        'name': '원티드랩 백승엽',
      },
      {
        'title': '잘 팔리는 디자이너가 되어보자',
        'body': '포트폴리오를 잘 만드는 법은 이미 많은 아티클과 강연을 통해...',
        'name': 'Wanted Creative',
      },
      {
        'title': '서류전형 실제로 그러할까?\n- 임휘진',
        'body': '머리로는 이해했지만, 막상\n활용하기에는 어려웠던 이력서...',
        'name': '원티드랩 김원우',
      },
      {
        'title': "메타버스 세상 속 브랜딩 전략 '후이넘스' | 이 회사 어때요?",
        'body': '재미를 추구하는 유저의 니즈에 충족하기 위해 기업은 새로운...',
        'name': 'Wanted',
      },
      {
        'title': '면접관이 말하는 프로덕트매니저의 포트폴리오?',
        'body': '도그냥TV의 새로운 컨텐츠가 시작되었습니다 :) 서비스기획...',
        'name': '도그냥',
      },
      {
        'title': "데이터가 안내하는 하이엔드 조각 투자 '트레져러' | 이 회사 어때요?",
        'body': '조각 투자를 통해 과거 소수 부자만이 참여했던 수집품 투자...',
        'name': 'Wanted',
      },
    ],
  };
}
