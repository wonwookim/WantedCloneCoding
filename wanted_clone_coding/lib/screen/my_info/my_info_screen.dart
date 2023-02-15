import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanted_clone_coding/controller/my_info_controller.dart';
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
                // _profile,
                // Container(
                //   child: Center(
                //     child: Text(
                //       '1',
                //       style: MyTextTheme.mainbold(context)
                //           .copyWith(color: AppColors.mainblack),
                //     ),
                //   ),
                // ),
                Container(
                  child: Center(
                    child: Text(
                      '2',
                      style: MyTextTheme.mainbold(context)
                          .copyWith(color: AppColors.mainblack),
                    ),
                  ),
                )
              ],
            )),
          ),
        )));
  }
}


// Widget _profile(context) {
//   return GestureDetector(
//     child: Column(
//       children: [
//               Image.asset(
//                 'assets/images /my_profile_call.png',
//                 height: 80,
//                 width: Get.width,
//               )
//       ],
//     ),
//   );
// }
