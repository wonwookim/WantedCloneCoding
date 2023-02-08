import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/color.dart';

class MyWantedScreen extends StatelessWidget {
  const MyWantedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // Container(
        //   margin: EdgeInsets.all(100.0),
        //   decoration:
        //       BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
        // ),
        CircleAvatar(
          radius: 60.0,
          backgroundColor: AppColors.maingray,
        ),
        Obx((() => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {}, child: const Text('사진 선택')),
                CupertinoActionSheetAction(
                    onPressed: () {}, child: const Text('사진 찍기'))
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text('취소'),
                onPressed: () {},
              ),
            )))
      ],
    ));
  }
}



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