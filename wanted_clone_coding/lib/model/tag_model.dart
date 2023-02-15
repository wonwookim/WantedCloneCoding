import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tag {
  Tag({required this.tagId,required this.tag, required this.isTap});
  int tagId;
  String tag;
  RxInt isTap;

  factory Tag.fromJson(Map<String, dynamic> json) =>
      Tag(tagId: json['tag_id'],tag: json['tag'], isTap: 0.obs);
}
