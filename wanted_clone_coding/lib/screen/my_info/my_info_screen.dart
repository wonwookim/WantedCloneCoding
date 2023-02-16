import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanted_clone_coding/controller/my_info_controller.dart';
import 'package:wanted_clone_coding/main.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/divided_widget.dart';
import 'package:wanted_clone_coding/widget/none_scroll_widget.dart';
import 'package:wanted_clone_coding/widget/tabbar_widget.dart';
import 'package:get/get.dart';

class MyInfoScreen extends StatelessWidget {
  MyInfoScreen({Key? key}) : super(key: key);
  MyInfoController controller = Get.put(MyInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '내 정보',
            style: MyTextTheme.mainboldheight(context).copyWith(fontSize: 15),
          ),
          elevation: 0,
          // bottom: TabBar(controller: controller.tabController, tabs: [
          //   Tab(
          //       child: Text(
          //     '프로필',
          //     style: MyTextTheme.mainbold(context),
          //   )),
          //   Tab(
          //       child: Text(
          //     '이력서',
          //     style: MyTextTheme.mainbold(context),
          //   ))
          // ]),
        ),
        body: RefreshConfiguration(
            child: ScrollNoneffectWidget(
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    backgroundColor: AppColors.mainWhite,
                    toolbarHeight: 44,
                    pinned: true,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: TabBarWidget(
                        tabController: controller.tabController,
                        tabs: const [
                          Tab(
                            height: 40,
                            child: Text(
                              "프로필",
                            ),
                          ),
                          Tab(
                            height: 40,
                            child: Text(
                              "이력서",
                            ),
                          ),
                        ]),
                  ),
                )
              ];
            },
            body: ScrollNoneffectWidget(
                child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                _profile(context),
                // Container(
                //   child: Center(
                //     child: Text(
                //       '1',
                //       style: MyTextTheme.mainbold(context)
                //           .copyWith(color: AppColors.mainblack),
                //     ),
                //   ),
                // ),
                _resume(context),
              ],
            )),
          ),
        )));
  }
}

Widget _profile(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        'assets/images /my_profile_call.png',
        height: 150,
        width: Get.width,
      ),
      // _jobsetting(context),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '기본 이력서',
          style: MyTextTheme.mainbold(context)
              .copyWith(fontSize: 12, color: AppColors.maingray),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.mainblue)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    '이력서 1',
                    style: TextStyle(color: AppColors.mainblue),
                  ),
                  Spacer(),
                  Text('>', style: TextStyle(color: AppColors.mainblue))
                ],
              ),
            )),
      ),
      DividedWidget(
        thickness: 1,
      ),
      profileplus(context,
          title: '간단 소개글', hintText: '안녕하세요. 신입 프론트엔드 개발자입니다.'),
      profileplus(context, title: '경력', hintText: '재직한 회사와 업무성과 등을 입력하세요'),
      profileplus(context, title: '학력', hintText: '학교와 학위, 전공 등을 입력하세요')
    ],
  );
}

Widget _resume(context) {
  return Column(
    children: [
      Image.asset(
        'assets/images /my_profile_call.png',
        height: 150,
        width: Get.width,
      ),
    ],
  );
}

// Widget _jobsetting(context) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           '프로필 열람 제외 기업',
//           style: MyTextTheme.mainbold(context)
//               .copyWith(fontSize: 12, color: AppColors.maingray),
//         ),
//       ),
//     ],
//   );
// }

Widget profileplus(context, {required String title, required String hintText}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              title,
              style: MyTextTheme.navigationTitle(context)
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 19),
            ),
            Spacer(),
            Text(
              '+',
              style: MyTextTheme.main(context)
                  .copyWith(color: AppColors.mainblue, fontSize: 24),
            )
          ],
        ),
      ),
      GestureDetector(
        child: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Divider(
            height: 1,
            color: AppColors.maingray,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Text(
          hintText,
          style: MyTextTheme.main(context)
              .copyWith(color: Color.fromARGB(191, 30, 27, 27)),
        ),
      ),
    ],
  );
}
