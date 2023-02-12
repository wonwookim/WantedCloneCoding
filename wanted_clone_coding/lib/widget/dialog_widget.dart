import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

void showOneButtonDialog({
  required String title,
  required String startContent,
  required Function() buttonFunction,
  required String buttonText,
}) {
  Get.dialog(
    Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.mainWhite),
              child: Column(mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  title,
                  style: MyTextTheme.mainbold(Get.context!)
                      .copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  startContent,
                  style: MyTextTheme.caption(Get.context!)
                      .copyWith(color: AppColors.mainblack),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  height: 1,
                ),
                GestureDetector(
                  onTap: buttonFunction,
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(color: AppColors.mainWhite),
                    child: Center(
                      child: Text(
                        '확인',
                        style: MyTextTheme.buttonfont(Get.context!)
                        .copyWith(color: AppColors.mainblue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.transparent.withOpacity(0.5),
  );
}
