import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RemoveScrollEffect extends StatelessWidget {
  RemoveScrollEffect({Key? key, required this.child}) : super(key: key);
  Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: ((notification) {
          notification.disallowIndicator();
          return false;
        }),
        child: child);
  }
}
