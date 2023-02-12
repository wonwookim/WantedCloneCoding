import 'dart:async';
import 'dart:convert';

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
  ScrollController sController = ScrollController();
  Timer? timer;
  Rx<ScreenState> screenState = ScreenState.normal.obs;
  RxList<PaletteColor> colors = <PaletteColor>[].obs;
  RxInt currentIndex = 0.obs;
  RxDouble tag_y = 0.0.obs;

  //----------Appbar Active-------------
  RxBool appbarActive = false.obs;

  //-----------tag-----------------------
  RxList<Tag> tagList = <Tag>[].obs;
  RxInt activeTag = 0.obs;
  RxBool isTap = false.obs; //Appbar가 아닌 일반 tag
  RxBool appBarTagIsTap = false.obs;
  //-----------------------------------
  RxMap<int, List<CareerInsight>> careerInsightField =
      <int, List<CareerInsight>>{}.obs;

  //----------key--------------------------
  GlobalKey gKey = GlobalKey();

  //--------eventList---------------------
  RxList<Event> eventList = <Event>[].obs;
  RxList<Event> eventForDevelopList = <Event>[].obs;
  @override
  void refresh() {
    super.refresh();
    appbarActive(false);
  }

  @override
  void onInit() async {
    await getTag().then((value) => getCareerInsight(activeTag.value));
    await getEventForCareerDevelopList();
    await getEventList();
    await getPalettes();
    screenState(ScreenState.success);
    timerstart();
    pController = PageController(
        viewportFraction: 0.9, initialPage: eventList.length * 100);
    sController.addListener(() {
      //Appbar 존재 유무
      if (sController.offset >= tag_y.value) {
        appbarActive(true);
      } else {
        appbarActive(false);
        appBarTagIsTap(false);
      }
    });
    pController.addListener(() {
      if (timer != null) {
        timer!.cancel();
        timerstart();
      }
    });
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tag_y.value = getPosition().dy;
    });
  }

  //------------팔레트 색 구하기 ------------------
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

//-----------------------------------------------get Tag Position------------------------------------------------------------------
  Offset getPosition() {
    final RenderBox renderBox =
        gKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    return offset;
  }

//------------------------------------Get event --------------------------------------------------------------------------------
  Future<void> getEventList() async {
    eventList.value = event_json.map((e) => Event.fromJson(e)).toList();
  }
//------------------------------------Get event for career develop ----------------------------------------------------

  Future<void> getEventForCareerDevelopList() async {
    eventForDevelopList.value =
        event_for_career_develop_json.map((e) => Event.fromJson(e)).toList();
  }

// ------------------------------------DUMMY DATA --------------------------------------------------------------------
  List<Map<String, dynamic>> event_json = [
    {
      'title': '우리 회사를 소개합니다.',
      'subtitle': '회사에 대한 정보, 원티드가 찾아드릴게요',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbRQgj4%2Fbtq3n9auUMk%2Fx1jFjVPF3vwrv7dWJZmLok%2Fimg.png',
    },
    {
      'title': '2022 개발자 리포트',
      'subtitle': '지금 무료로 다운받으세요!',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image': 'https://static.wanted.co.kr/images/events/2680/11ae45d0.jpg'
    },
    {
      'title': '원티드 매거진 & Workers',
      'subtitle': '무료 다운로드하고 경품도 받으세요!',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image': 'https://static.wanted.co.kr/images/events/1797/dac1b4f4.jpg'
    },
  ];
  List<Map<String, dynamic>> event_for_career_develop_json = [
    {
      'title': "스터디살롱: '직원경험' 개념 잡기",
      'start_date': "20230111",
      'end_date': "20230212",
      'tag': [
        {'tag_id': 10, 'tag': 'HR'},
        {'tag_id': 11, 'tag': '회사생활'}
      ],
      'image': 'http://photo.sentv.co.kr/photo/2020/08/24/20200824100748.jpg',
      'type': 'event'
    },
    {
      'title': "인사담당자가 직접 말하는, 서류 통과가 잘 되는 이력서",
      'tag': [
        {'tag_id': 12, 'tag': '취업/이직'},
      ],
      'image':
          'https://binaries.templates.cdn.office.net/support/templates/ko-kr/lt16412178_quantized.png',
      'type': 'article'
    },
    {
      'title': "새로운 시작, 전직 지원 프로그램",
      'tag': [
        {'tag_id': 12, 'tag': '취업/이직'},
      ],
      'image':
          'http://openimage.interpark.com/goods_image_big/3/0/9/2/7806713092_l.jpg',
      'type': 'promotion'
    },
    {
      'title': "나다운 일의 시작, 원티드",
      'tag': [
        {'tag_id': 13, 'tag': '브랜딩'},
        {'tag_id': 12, 'tag': '취업/이직'},
        {'tag_id': 14, 'tag': '라이프스타일'},
      ],
      'image': 'https://static.wanted.co.kr/images/events/2255/f38b1a9d.jpg',
      'type': 'campain'
    },
    {
      'title': "합격하는 면접자의 비밀",
      'tag': [
        {'tag_id': 15, 'tag': '커리어고민'},
        {'tag_id': 12, 'tag': '취업/이직'},
        {'tag_id': 16, 'tag': '시리즈'},
      ],
      'image':
          'https://image.aladin.co.kr/product/2803/20/letslook/8967990197_toc1.jpg',
      'type': 'vod'
    },
    {
      'title': "프리온보딩 프론트엔드 인턴십",
      'tag': [
        {'tag_id': 12, 'tag': '취업/이직'},
        {'tag_id': 17, 'tag': '개발'},
        {'tag_id': 18, 'tag': '교육'},
      ],
      'start_date': "20230125",
      'end_date': "20230217",
      'image': 'https://static.wanted.co.kr/images/events/2693/bb92c6fd.jpg',
      'type': 'edu'
    }
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
