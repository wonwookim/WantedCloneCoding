import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wanted_clone_coding/model/company_model.dart';
import 'package:wanted_clone_coding/model/employ_theme_model.dart';
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
  RxList<Event> currentUpPositionList = <Event>[].obs;
  RxList<Company> foodReceiveCompanyList = <Company>[].obs;
  RxList<Company> under50CompanyList = <Company>[].obs;

  RxList<EmployTheme> employThemeList = <EmployTheme>[].obs;
  @override
  void onInit() async {
    await getEventList();
    await getPalettes();
    await getCompany();
    await getEmploymentTheme();
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

  //------------????????? ??? ????????? ------------------
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
    currentUpPositionList.value = current_up_position_json.map((e) => Event.fromJson(e)).toList();
  }

  Future<void> getCompany() async {
    Map<String, List<Company>> company_list = <String, List<Company>>{};
    company_json.forEach((key, value) {
      company_list[key] = value.map((e) => Company.fromJson(e)).toList();
    });
    foodReceiveCompanyList.value = company_list['food_receive']!;
    under50CompanyList.value = company_list['under_50']!;
  }

  Future<void> getEmploymentTheme() async {
    employThemeList.value =
        employ_theme_json.map((e) => EmployTheme.fromjson(e)).toList();
  }

  //-------------------------dummy data-----------------------------
  List<Map<String, dynamic>> recruit_json = [
    {
      'type': 'recruit',
      'title': '????????? ???????????? ?????????, ????????????',
      'subtitle': '???????????? ?????? ???',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image': 'https://cdn.imweb.me/thumbnail/20220604/63df980e50c50.png',
    },
    {
      'type': 'event',
      'title': '?????? 100??? ?????? ?????? ?????? ??????',
      'subtitle': '?????? ??? ????????? ????????????',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://contents.nextunicorn.kr/company/179b45c219945a65/rep-76e017d744e6279i5fc77199f3f55994cffa.png?s=640x&t=cover&f=jpg'
    },
    {
      'type': 'recruit',
      'title': "'100??? ????????????' XYZ",
      'subtitle': '???????????? ????????? ??????, ?????? ????????????',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://cdn.imweb.me/upload/S202201267a1bf4b51a6a5/8b289e6b017e4.png'
    },
  ];

  List<Map<String, dynamic>> suggest_position_json = [
    {
      'title': '??????????????? ?????????',
      'subtitle': '???????????????',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'image':
          'https://www.itworld.co.kr/files/itworld/2020/02/How%20to%20run%20Android%20apps%20in%20Windows-1.jpg',
    },
    {
      'title': '??? ??????',
      'subtitle': '??????????????????',
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'http://www.newsroad.co.kr/news/photo/202208/18229_19424_2032.png'
    },
    {
      'title': '??????????????? ?????????',
      'subtitle': '????????????????????????',
      'location': '?????? ?? ??????',
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
      'title': 'CS / CX ?????????',
      'subtitle': '???????????????',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'image':
          'https://static.wanted.co.kr/images/company/23597/xkkgdj0zuhuv1auw__1080_790.jpg',
    },
    {
      'title': '?????????_Django ?????? ????????? (1??? ??????)',
      'subtitle': '???????????????',
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://compphoto.incruit.com/2023/01/%EC%9B%90%ED%8B%B0%EB%93%9C%2020.jpg'
    },
    {
      'title': 'Backend Developer',
      'subtitle': '????????????',
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://static.wanted.co.kr/images/company/35924/gfgua8so8rbskvba__1080_790.jpg'
    },
  ];

  Map<String, List<Map<String, dynamic>>> company_json = {
    "food_receive": [
      {
        'name': '????????????(CONNECT.ED)',
        'field': 'IT, ?????????',
        'image':
            'https://pds.saramin.co.kr/company/logo/202007/28/qe4wpz_kmlx-wbfptb_logo.png',
        'intro_image':
            'https://static.wanted.co.kr/images/company/13950/yidnem3qmpzrjwes__1080_790.jpg'
      },
      {
        'name': '?????????????????????',
        'field': 'IT, ?????????',
        'image':
            'https://static.wanted.co.kr/images/company/683/h56ounn4t9lidpev__1080_790.jpg',
        'intro_image':
            'https://static.wanted.co.kr/images/company/683/ow0zklm8mvwdjn5s__1080_790.jpg'
      },
      {
        'name': '???????????????',
        'field': 'IT, ?????????',
        'image':
            'https://image.rocketpunch.com/company/84709/mustmove_logo_1649148081.jpg?s=400x400&t=inside',
        'intro_image':
            'https://image.wanted.co.kr/optimize?src=https%3A%2F%2Fstatic.wanted.co.kr%2Fimages%2Fcompany%2F23314%2Fibg8vhvympxxqhhg__1080_790.jpg&w=1000&q=75'
      }
    ],
    "under_50": [
      {
        'name': '???????????????',
        'field': '??????',
        'image':
            'https://static.wanted.co.kr/images/company/35999/gdicjyve3hbtfe8q__1080_790.jpg',
        'intro_image':
            'https://wowtale.net/wp-content/uploads/2021/12/20211223-JBventures.jpeg'
      },
      {
        'name': '??????????????????',
        'field': 'IT, ?????????',
        'image':
            'https://grepp-programmers.s3.amazonaws.com/production/company/logo/7283/logo-6.png',
        'intro_image':
            'https://asset.programmers.co.kr/image/resize/production/company/156539/m_bd00f6c0-8b62-4190-ac33-af751d560d94.jpg'
      },
      {
        'name': '??????',
        'field': 'IT, ?????????',
        'image':
            'https://image.rocketpunch.com/company/16270/weebur_logo_1656643747.jpg?s=400x400&t=inside',
        'intro_image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr91EFxMZENbAahR_vJLaDjc4aOS-cIrWqI73Jo6nR9iTsbI_G4xOs1FSDUMa-8jKEBFg&usqp=CAU'
      }
    ]
  };

  List<Map<String, dynamic>> employ_theme_json = [
    {
      'title': '?????? 100??? ?????? ?????? ?????? ?????? ?????? ?????????',
      'subtitle': '?????? 100??? ?????? ?????? ?????? ?????? - ?????? ?????????',
      'body': '?????? 6?????? ??? ????????? ?????? ????????? ????????? ???????????? ???????????? ???????????? ???????????????.',
      'image':
          'https://1.bp.blogspot.com/-GJWxOqkQFxM/X87jX3qjCuI/AAAAAAAA954/mc7VB8_GpXoAuizMfd92v4GxRvLJQmfVACLcBGAsYHQ/s2048/ilya-pavlov-OqtafYT5kTw-unsplash.jpg',
      'company_list': [
        {
          'name': '????????????(CONNECT.ED)',
          'field': 'IT, ?????????',
          'image':
              'https://pds.saramin.co.kr/company/logo/202007/28/qe4wpz_kmlx-wbfptb_logo.png',
          'intro_image':
              'https://static.wanted.co.kr/images/company/13950/yidnem3qmpzrjwes__1080_790.jpg'
        },
        {
          'name': '?????????????????????',
          'field': 'IT, ?????????',
          'image':
              'https://static.wanted.co.kr/images/company/683/h56ounn4t9lidpev__1080_790.jpg',
          'intro_image':
              'https://static.wanted.co.kr/images/company/683/ow0zklm8mvwdjn5s__1080_790.jpg'
        },
        {
          'name': '???????????????',
          'field': 'IT, ?????????',
          'image':
              'https://image.rocketpunch.com/company/84709/mustmove_logo_1649148081.jpg?s=400x400&t=inside',
          'intro_image':
              'https://image.wanted.co.kr/optimize?src=https%3A%2F%2Fstatic.wanted.co.kr%2Fimages%2Fcompany%2F23314%2Fibg8vhvympxxqhhg__1080_790.jpg&w=1000&q=75'
        },
        {
          'name': '???????????????',
          'field': '??????',
          'image':
              'https://static.wanted.co.kr/images/company/35999/gdicjyve3hbtfe8q__1080_790.jpg',
          'intro_image':
              'https://wowtale.net/wp-content/uploads/2021/12/20211223-JBventures.jpeg'
        },
        {
          'name': '??????????????????',
          'field': 'IT, ?????????',
          'image':
              'https://grepp-programmers.s3.amazonaws.com/production/company/logo/7283/logo-6.png',
          'intro_image':
              'https://asset.programmers.co.kr/image/resize/production/company/156539/m_bd00f6c0-8b62-4190-ac33-af751d560d94.jpg'
        },
        {
          'name': '??????',
          'field': 'IT, ?????????',
          'image':
              'https://image.rocketpunch.com/company/16270/weebur_logo_1656643747.jpg?s=400x400&t=inside',
          'intro_image':
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr91EFxMZENbAahR_vJLaDjc4aOS-cIrWqI73Jo6nR9iTsbI_G4xOs1FSDUMa-8jKEBFg&usqp=CAU'
        }
      ]
    },
    {
      'title': '?????????',
      'subtitle': '?????? ?????????',
      'body':
          '?????????, ?????????, ???????????????! ??? ????????? ?????? ?????? ???????????? ???????????????. ????????? ?????? ??????????????? ?????? ?????????????????????.',
      'image': 'https://img.hankyung.com/photo/201707/01.14340760.1.jpg',
      'company_list': [
        {
          'name': '????????????(CONNECT.ED)',
          'field': 'IT, ?????????',
          'image':
              'https://pds.saramin.co.kr/company/logo/202007/28/qe4wpz_kmlx-wbfptb_logo.png',
          'intro_image':
              'https://static.wanted.co.kr/images/company/13950/yidnem3qmpzrjwes__1080_790.jpg'
        },
        {
          'name': '?????????????????????',
          'field': 'IT, ?????????',
          'image':
              'https://static.wanted.co.kr/images/company/683/h56ounn4t9lidpev__1080_790.jpg',
          'intro_image':
              'https://static.wanted.co.kr/images/company/683/ow0zklm8mvwdjn5s__1080_790.jpg'
        },
        {
          'name': '???????????????',
          'field': 'IT, ?????????',
          'image':
              'https://image.rocketpunch.com/company/84709/mustmove_logo_1649148081.jpg?s=400x400&t=inside',
          'intro_image':
              'https://image.wanted.co.kr/optimize?src=https%3A%2F%2Fstatic.wanted.co.kr%2Fimages%2Fcompany%2F23314%2Fibg8vhvympxxqhhg__1080_790.jpg&w=1000&q=75'
        },
        {
          'name': '???????????????',
          'field': '??????',
          'image':
              'https://static.wanted.co.kr/images/company/35999/gdicjyve3hbtfe8q__1080_790.jpg',
          'intro_image':
              'https://wowtale.net/wp-content/uploads/2021/12/20211223-JBventures.jpeg'
        },
        {
          'name': '??????????????????',
          'field': 'IT, ?????????',
          'image':
              'https://grepp-programmers.s3.amazonaws.com/production/company/logo/7283/logo-6.png',
          'intro_image':
              'https://asset.programmers.co.kr/image/resize/production/company/156539/m_bd00f6c0-8b62-4190-ac33-af751d560d94.jpg'
        },
        {
          'name': '??????',
          'field': 'IT, ?????????',
          'image':
              'https://image.rocketpunch.com/company/16270/weebur_logo_1656643747.jpg?s=400x400&t=inside',
          'intro_image':
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr91EFxMZENbAahR_vJLaDjc4aOS-cIrWqI73Jo6nR9iTsbI_G4xOs1FSDUMa-8jKEBFg&usqp=CAU'
        }
      ]
    },
    {
      'title': 'EA????????? ??????',
      'subtitle': 'EA????????? ??????',
      'body': "We're in the Game. Join out Game",
      'image':
          'https://compphoto.incruit.com/2014/08/%ED%9A%8C%EC%9D%98%EC%8B%A4_2.jpg',
      'company_list': [
        {
          'name': 'Electronic Arts Korea(EA Korea)',
          'field': 'IT, ?????????',
          'image':
              'https://d32gkk464bsqbe.cloudfront.net/company-profiles/o/8cfdf72c99de043a560e95d28cefde45a0a26d56.jpeg?v=6.8.6',
          'intro_image': ''
        },
      ]
    }
  ];

  List<Map<String, dynamic>> current_up_position_json = [
    {
      'title': 'Backend Developer',
      'subtitle': '????????????',
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://static.wanted.co.kr/images/company/35924/gfgua8so8rbskvba__1080_790.jpg'
    },
    {
      'title': 'CS / CX ?????????',
      'subtitle': '???????????????',
      'start_date': null,
      'end_date': null,
      'tag': null,
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'image':
          'https://static.wanted.co.kr/images/company/23597/xkkgdj0zuhuv1auw__1080_790.jpg',
    },
    {
      'title': '?????????_Django ?????? ????????? (1??? ??????)',
      'subtitle': '???????????????',
      'location': '?????? ?? ??????',
      'reward': 1000000,
      'start_date': null,
      'end_date': null,
      'tag': null,
      'image':
          'https://compphoto.incruit.com/2023/01/%EC%9B%90%ED%8B%B0%EB%93%9C%2020.jpg'
    },
  ];
}
