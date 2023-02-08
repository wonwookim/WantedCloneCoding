import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

void showOneButtonDialog({
  required String title,
  required String startContent,
  String? highlightContent,
  String? endContent,
  required Function() buttonFunction,
  required String buttonText,
  Color? highlightColor,
  Color? btnColor,
  Color? btnTextColor,
}) {
  Get.dialog(
    Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.mainWhite),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    title,
                    style: MyTextTheme.mainbold(Get.context!),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: startContent,
                        style: MyTextTheme.mainheight(Get.context!),
                      ),
                      TextSpan(
                        text: highlightContent ?? "",
                        style: MyTextTheme.mainheight(Get.context!).copyWith(
                            color: highlightColor ?? AppColors.mainblue),
                      ),
                      TextSpan(
                        text: endContent,
                        style: MyTextTheme.mainheight(Get.context!),
                      )
                    ]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
    barrierColor: AppColors.popupGray,
  );
}