import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/utils/font.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home', style: MyTextTheme.size_22(context),),elevation: 0,),
      body: Container(),
    );
  }
}