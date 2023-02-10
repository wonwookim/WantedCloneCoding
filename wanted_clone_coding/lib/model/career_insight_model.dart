import 'package:flutter/material.dart';

class CareerInsight {
  CareerInsight(
      {required this.title,
      required this.body,
      required this.name,
      required this.mainImg,
      required this.profileImg});
  String title;
  String body;
  String name;
  String mainImg;
  String profileImg;

  factory CareerInsight.fromJson(Map<String, dynamic> json) => CareerInsight(
      title: json['title'],
      body: json['body'],
      name: json['name'],
      mainImg: json['main_img'],
      profileImg: json['profile_img']);
}
