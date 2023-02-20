import 'package:flutter/material.dart';
import 'package:wanted_clone_coding/model/company_model.dart';
import 'package:wanted_clone_coding/model/event_model.dart';

class EmployTheme {
  EmployTheme(
      {required this.image,
      required this.body,
      required this.subtitle,
      required this.title,
      required this.companyList});
  String image;
  String title;
  String subtitle;
  String body;
  List<Company> companyList;

  factory EmployTheme.fromjson(Map<String, dynamic> json) => EmployTheme(
      image: json['image'] != null ? json['image'] : '',
      body: json['body'],
      subtitle: json['subtitle'],
      title: json['title'],
      companyList: List.from(json['company_list'])
          .map((e) => Company.fromJson(e))
          .toList());
}
