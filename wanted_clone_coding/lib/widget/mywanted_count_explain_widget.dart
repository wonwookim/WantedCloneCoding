import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/color.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class CountExplain extends StatelessWidget {
  CountExplain({Key? key, required this.count, required this.explain})
      : super(key: key);

  String count;
  String explain;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(
            count,
            style: MyTextTheme.mainheight(context),
          ),
          const SizedBox(height: 8),
          Text(explain, style: MyTextTheme.main(context))
        ],
      ),
    );
  }
}
