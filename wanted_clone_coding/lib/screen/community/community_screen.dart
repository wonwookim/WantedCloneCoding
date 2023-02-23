import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/community_controller.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/divided_widget.dart';
import 'package:wanted_clone_coding/widget/tap_widget.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({Key? key}) : super(key: key);
  CommunityController controller = Get.put(CommunityController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(controller.isTap.value ? kToolbarHeight + 98 : kToolbarHeight +55 ),
            child: AppbarWidget(
              screen: Screen.community,
              screenState: controller.screenState,
              actions: [
                SvgPicture.asset('assets/icons/profile_image.svg',
                    color: const Color(0xFF333333)),
                const SizedBox(
                  width: 16,
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(controller.isTap.value ? 98 : 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DividedWidget(
                      height: 1,
                      thickness: 0.3,
                      color: const Color(0xFFB2B2B2),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: TapWidget(isTap: controller.isTap, tagList: controller.tagList, activeTag: controller.activeTag, changePage: controller.get,),
                    // )
                  ],
                ),
              ),
            )),
        body: Container(),
      ),
    );
  }
}
