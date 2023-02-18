import 'package:flutter/material.dart';

class Company {
  Company({
    required this.name,
    required this.slogan,
    required this.field,
    required this.image,
    required this.introImage
  });
  String name;
  String slogan;
  String field;
  String image;
  String introImage;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
      name: json['name'],
      slogan: json['slogan'] != null ? json['slogan'] : '',
      field: json['field'],
      image: json['image'] != null ? json['image'] : '',
      introImage: json['intro_image'] != null ? json['intro_image'] : '',
      );
}
