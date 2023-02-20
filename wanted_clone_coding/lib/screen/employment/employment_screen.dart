import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/controller/employment_controller.dart';
import 'package:wanted_clone_coding/model/company_model.dart';
import 'package:wanted_clone_coding/model/employ_theme_model.dart';
import 'package:wanted_clone_coding/model/event_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/constant.dart';
import 'package:wanted_clone_coding/utils/font.dart';
import 'package:wanted_clone_coding/widget/appbar_widget.dart';
import 'package:wanted_clone_coding/widget/auto_change_widget.dart';
import 'package:wanted_clone_coding/widget/button_widget.dart';
import 'package:wanted_clone_coding/widget/divided_widget.dart';
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
                    under_50_Company(context),
                    const SizedBox(height: 40),
                    DividedWidget(
                      height: 8,
                    ),
                    const SizedBox(height: 40),
                    currentEmploymentWithTheme(context),
                    const SizedBox(height: 40),
                    DividedWidget(
                      height: 8,
                    ),
                    const SizedBox(height: 40),
                    currentUpPosition(context)
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
          height: 235,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      .copyWith(fontSize: 16, color:const Color(0xFF434343)))
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
                      .copyWith(fontSize: 16, color: const Color(0xFF434343)))
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

  Widget currentEmploymentWithTheme(context) {
    return Column(
      children: [
        IntroWidget(
            title: Text('테마로 모아보는 요즘 채용',
                style: MyTextTheme.mainbold(context).copyWith(
                    fontSize: 17, height: 1.5, color: AppColors.mainblack)),
            moreView: ''),
        const SizedBox(height: 7),
        SizedBox(
          height: 300,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return currentEmploymentWithThemeWidget(
                    context, controller.employThemeList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: controller.employThemeList.length),
        )
      ],
    );
  }

  Widget currentUpPosition(context) {
    return Column(
      children: [
        IntroWidget(
            title: Text('요즘 뜨는 포지션',
                style: MyTextTheme.mainbold(context).copyWith(
                    fontSize: 17, height: 1.5, color: AppColors.mainblack)),
            moreView: ''),
        const SizedBox(height: 20),
        SizedBox(
          height: 235,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return eventWidget(context,
                    event: controller.currentUpPositionList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: controller.currentUpPositionList.length),
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
    return Container(width: 160, height: 235,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      ]),
    );
  }

  Widget currentEmploymentWithThemeWidget(context, EmployTheme employTheme) {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoImageWidget(
            height: 185,
            width: 320,
            imgUrl: employTheme.image,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  employTheme.title,
                  style: MyTextTheme.size_22(context)
                      .copyWith(color: AppColors.mainWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            employTheme.subtitle,
            style: MyTextTheme.mainbold(context)
                .copyWith(color: AppColors.mainblack),
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              employTheme.body,
              style: MyTextTheme.size_12_bold(context)
                  .copyWith(color: AppColors.textGray),
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 25,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InfoImageWidget(
                          height: 25,
                          width: 25,
                          imgUrl: employTheme.companyList[index].image);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 6);
                    },
                    itemCount: employTheme.companyList.length > 7
                        ? 7
                        : employTheme.companyList.length),
              ),
              const SizedBox(width: 10),
              if (employTheme.companyList.length > 7)
                Text(
                  "+${employTheme.companyList.length - 7}개 기업",
                  style: MyTextTheme.size_12_bold(context)
                      .copyWith(color: const Color(0xFF696969)),
                )
            ],
          )
        ],
      ),
    );
  }
}
