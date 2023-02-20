import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/employment_controller.dart';
import 'package:wanted_clone_coding/model/company_model.dart';
import 'package:wanted_clone_coding/model/event_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/auto_change_widget.dart';
import 'package:wanted_clone_coding/widget/button_widget.dart';
import 'package:wanted_clone_coding/widget/info_image_widget.dart';
import 'package:wanted_clone_coding/widget/intro_widget.dart';
import 'package:wanted_clone_coding/widget/remove_scroll_effect_widget.dart';

class EmploymentScreen extends StatelessWidget {
  EmploymentScreen({Key? key}) : super(key: key);
  EmploymentController controller = Get.put(EmploymentController());
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Obx(
      () => Scaffold(
        body: RemoveScrollEffect(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    change_color_area(),
                    if (controller.screenState.value == ScreenState.success)
                      Positioned(
                          top: statusBarHeight + kToolbarHeight + 20,
                          child: AutoChangeWidget(
                            controller: controller.pController,
                            eventList: controller.recruitList,
                            currentIndex: controller.currentIndex,
                          )),
                  ],
                ),
                if (controller.screenState.value == ScreenState.success)
                  Column(children: [
                    gotoRecruitPosition(context),
                    const SizedBox(height: 40),
                    suggestAIPosition(context),
                    const SizedBox(height: 40),
                    receiveCompany(context),
                    const SizedBox(height: 40),
                    under_50_Company(context)
                  ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget change_color_area() {
    return Column(children: [
      Obx(
        () => Container(
          decoration: BoxDecoration(
              color: controller.colors.isNotEmpty
                  ? controller.colors[controller.currentIndex.value].color
                  : AppColors.mainblue),
          height: 275,
          child: Column(
            children: [
              AppbarWidget(
                screen: Screen.employment,
                screenState: controller.screenState,
              ),
              const Divider(
                height: 1,
                color: AppColors.maingray,
              )
            ],
          ),
        ),
      ),
      const SizedBox(height: 70),
    ]);
  }

  Widget gotoRecruitPosition(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF4AA4F7),
              AppColors.mainblue,
              Color(0xFF4AA4F7)
            ], stops: [
              0.1,
              0.5,
              0.9
            ]),
            borderRadius: BorderRadius.circular(32)),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/search.svg',
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 12,
            ),
            Text('채용 중인 포지션 보러 가기',
                style: MyTextTheme.mainbold(context)
                    .copyWith(color: AppColors.mainWhite))
          ],
        ),
      ),
    );
  }

  Widget recentViewPosition(context) {
    return Column(
      children: [
        IntroWidget(
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: '최근 본 포지션',
                  style: MyTextTheme.size_12_bold(context)
                      .copyWith(fontSize: 17, color: AppColors.mainblack))
            ])),
            moreView: '전체보기'),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget suggestAIPosition(context) {
    return Column(
      children: [
        IntroWidget(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'wanted ai ',
                      style: MyTextTheme.size_22(context)
                          .copyWith(height: 1.5, color: AppColors.mainblack)),
                  TextSpan(
                      text: '가 제안하는',
                      style: MyTextTheme.main(context).copyWith(
                          height: 1.5,
                          fontSize: 17,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w700)),
                ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('합격률 높은 포지션',
                        style: MyTextTheme.main(context).copyWith(
                            height: 1.5,
                            fontSize: 17,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    SvgPicture.asset('assets/icons/information.svg')
                  ],
                )
              ],
            ),
            moreView: '전체보기'),
        const SizedBox(height: 20),
        SizedBox(
          height: 220,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return eventWidget(context,
                    event: controller.suggestList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: controller.suggestList.length),
        )
      ],
    );
  }

  Widget receiveCompany(context) {
    return Column(
      children: [
        IntroWidget(
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "#식사·간식 제공 \u{2615}\n",
                  style: MyTextTheme.mainbold(context).copyWith(
                      fontSize: 17, height: 1.5, color: AppColors.mainblack)),
              TextSpan(
                  text: '회사들을 모아봤어요',
                  style: MyTextTheme.main(context)
                      .copyWith(fontSize: 16, color: Color(0xFF434343)))
            ])),
            moreView: '포지션으로 더보기'),
        const SizedBox(height: 20),
        SizedBox(
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
              itemBuilder: (context, index) {
                return companyWidget(context,
                    company: controller.foodReceiveCompanyList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: controller.foodReceiveCompanyList.length),
        )
      ],
    );
  }

  Widget under_50_Company(context) {
    return Column(
      children: [
        IntroWidget(
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "#50인 이하 \u{2B07}\n",
                  style: MyTextTheme.mainbold(context).copyWith(
                      fontSize: 17, height: 1.5, color: AppColors.mainblack)),
              TextSpan(
                  text: '회사들을 모아봤어요',
                  style: MyTextTheme.main(context)
                      .copyWith(fontSize: 16, color: Color(0xFF434343)))
            ])),
            moreView: '포지션으로 더보기'),
        const SizedBox(height: 20),
        SizedBox(
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
              itemBuilder: (context, index) {
                return companyWidget(context,
                    company: controller.under50CompanyList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: controller.under50CompanyList.length),
        )
      ],
    );
  }

  Widget companyWidget(context, {required Company company}) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          InfoImageWidget(height: 170, width: 300, imgUrl: company.introImage),
          const SizedBox(height: 12),
          Row(
            children: [
              InfoImageWidget(height: 35, width: 35, imgUrl: company.image),
              const SizedBox(width: 7),
              RichText(
                  maxLines: 3,
                  text: TextSpan(children: [
                    TextSpan(
                        text: '${company.name}\n',
                        style: MyTextTheme.mainbold(context).copyWith(
                            fontSize: 16,
                            height: 1.5,
                            color: AppColors.mainblack)),
                    TextSpan(
                        text: company.field,
                        style: MyTextTheme.size_12_bold(context)
                            .copyWith(color: AppColors.textGray))
                  ])),
              const Spacer(),
              ButtonWidget(
                onTap: () {},
                btnColor: AppColors.mainWhite,
                btnText: '팔로우 ',
                height: 35,
                width: 80,
                textColor: AppColors.mainblue,
                borderColor: AppColors.cardGray,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget eventWidget(context, {required Event event}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InfoImageWidget(height: 120, width: 160, imgUrl: event.image),
      const SizedBox(height: 10),
      Text(
        event.title,
        style:
            MyTextTheme.mainbold(context).copyWith(color: AppColors.mainblack),
        maxLines: 2,
      ),
      const SizedBox(height: 8),
      Text(
        event.subtitle,
        style: MyTextTheme.size_12_bold(context)
            .copyWith(color: AppColors.mainblack),
      ),
      const SizedBox(height: 8),
      Text(event.location,
          style: MyTextTheme.size_12_bold(context)
              .copyWith(color: AppColors.textGray)),
      const SizedBox(height: 8),
      Text(
        '채용보상금 ${event.reward}원',
        style: MyTextTheme.size_12(context).copyWith(color: Color(0xFF404040)),
      )
    ]);
  }
}
