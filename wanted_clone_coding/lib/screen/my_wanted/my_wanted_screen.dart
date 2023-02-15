import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/button_widget.dart';
import 'package:wanted_clone_coding/widget/divided_widget.dart';
import 'package:wanted_clone_coding/widget/mywanted_buttonList_widget.dart';
import 'package:wanted_clone_coding/widget/mywanted_count_explain_widget.dart';

class MyWantedScreen extends StatelessWidget {
  MyWantedScreen({Key? key}) : super(key: key);

  // MyWantedController controller = MyWantedController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MY 원티드',
            style: MyTextTheme.mainboldheight(context).copyWith(fontSize: 15),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          // controller: controller.,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              profileInfo(context),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: ButtonWidget(
                  onTap: () {},
                  btnColor: AppColors.dividegray,
                  btnText:
                      '요즘 내 관심사는? 선택하고 맞춤 콘텐츠 받기!                                                         >',
                  fontSize: 10,
                  height: 30,
                  width: Get.width,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _userinterest(context,
                      svg: 'assets/icons/heart.svg', explain: '좋아요 0'),
                  _userinterest(context,
                      svg: 'assets/icons/bookmark.svg', explain: '북마크 0'),
                  _userinterest(context,
                      svg: 'assets/icons/interestcompany.svg',
                      explain: '관심회사 0'),
                ],
              ),
              DividedWidget(
                height: 1,
              ),
              _profile(context),
              DividedWidget(
                height: 1,
              ),
              Image.asset(
                'assets/images /career_pay_test.png',
                height: 80,
                width: Get.width,
              ),
              _suggestSituation(context),
              _supportSituation(context),
              ButtonListWidget(
                  onTap: () {},
                  title: '일하는 유형',
                  explain: '나에게 어울리는 회사, 1분 만에 알아볼까요? ',
                  btnText: '유형테스트 하러가기'),
              ButtonListWidget(
                  onTap: () {},
                  title: 'MY 영상',
                  explain: '이벤트 메뉴에서 영상을 구매.추가해보세요',
                  btnText: '이벤트 바로가기'),
              ButtonListWidget(
                  onTap: () {},
                  title: '추천',
                  explain: '좋은 사람과 좋은 회사가 더 많이 연결되도록 \n 추천하고, 추천받고, 성장하세요',
                  btnText: '추천 시작하기')

              // Container(
              //   margin: EdgeInsets.all(100.0),
              //   decoration:
              //       BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              // ),
              // Obx((() => CupertinoActionSheet(
              //       actions: [
              //         CupertinoActionSheetAction(
              //             onPressed: () {}, child: const Text('사진 선택')),
              //         CupertinoActionSheetAction(
              //             onPressed: () {}, child: const Text('사진 찍기'))
              //       ],
              //       cancelButton: CupertinoActionSheetAction(
              //         child: Text('취소'),
              //         onPressed: () {},
              //       ),
              //     )))
            ],
          ),
        ));
  }
}

Widget profileInfo(BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('https://picsum.photos/250?image=9'),
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Center(child: Text('+')),
              ),
            )
          ],
        ),
      ),
      Text(
        '김규희',
        style: MyTextTheme.mainbold(context).copyWith(fontSize: 16),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ButtonWidget(
          onTap: () {},
          btnColor: AppColors.mainWhite,
          btnText: '0P',
          fontSize: 15,
          textColor: Colors.black,
          height: 35,
          width: 120,
          borderColor: AppColors.dividegray,
        ),
      ),
    ],
  );
}

Widget _profile(context) {
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(
        '프로필',
        textAlign: TextAlign.start,
        style: MyTextTheme.mainbold(context).copyWith(fontSize: 15),
      ),
    ),
    Center(
        child: Text(
      '간단한 소개만 작성해도 면접 제안을 받을 수 있어요!',
      style: MyTextTheme.main(context).copyWith(fontSize: 13),
    )),
    SizedBox(
      height: 16,
    ),
    GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            child: Text('간단 이력 추가하고 매치업 시작하기',
                style: MyTextTheme.mainboldheight(context)
                    .copyWith(color: AppColors.mainblue, fontSize: 14)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.mainblue, width: 1.0)),
        ),
      ),
    ),
    SizedBox(
      height: 32,
    )
  ]);
}

Widget _suggestSituation(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      DividedWidget(
        height: 1,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text('제안받기 현황',
            style: MyTextTheme.mainbold(context).copyWith(fontSize: 15)),
      ),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 90,
          decoration: BoxDecoration(color: AppColors.dividegray),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23),
              child: CountExplain(
                count: '0',
                explain: '관심있음',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23),
              child: CountExplain(
                count: '0',
                explain: '열람',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23),
              child: CountExplain(
                count: '0',
                explain: '받은 제안',
              ),
            ),
          ]),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}

Widget _supportSituation(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      DividedWidget(
        height: 1,
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('지원 현황',
            style: MyTextTheme.mainbold(context).copyWith(fontSize: 15)),
      ),
      // ListView.separated(
      //     scrollDirection: Axis.horizontal,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Center(
      //           child: CountExplain(
      //             count: '0',
      //             explain: '지원 완료',
      //           ),
      //         ),
      //       );
      //     },
      //     separatorBuilder: (BuildContext context, int index) =>
      //         const Divider(),
      //     itemCount: 4),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
          child: CountExplain(
            count: '0',
            explain: '지원 완료',
          ),
        ),
        CountExplain(
          count: '0',
          explain: '서류 통과',
        ),
        CountExplain(
          count: '0',
          explain: '최종 합격',
        ),
        CountExplain(
          count: '0',
          explain: '불합격',
        )
      ]),
      const SizedBox(
        height: 40,
      )
    ],
  );
}

Widget _userinterest(context, {required String svg, required String explain}) {
  return GestureDetector(
    child: Column(
      children: [
        SvgPicture.asset(
          svg,
          height: 18,
          width: 18,
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          explain,
          style: MyTextTheme.main(context).copyWith(fontSize: 12),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    ),
  );
}
