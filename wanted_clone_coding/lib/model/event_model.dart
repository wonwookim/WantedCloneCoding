import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanted_clone_coding/model/tag_model.dart';
import 'package:wanted_clone_coding/utils/color.dart';

enum EventType {
  campain('캠페인', AppColors.campainColor),
  article('아티클', AppColors.campainColor),
  vod('VOD', AppColors.vodColor),
  event('이벤트', AppColors.eventColor),
  promotion('프로모션', AppColors.promotionColor),
  edu('교육', AppColors.eduColor),
  recruit('REQURIT', AppColors.mainWhite);

  final String type;
  final Color color;
  const EventType(this.type, this.color);
}

class Event {
  Event(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.startDate,
      required this.endDate,
      required this.reward,
      required this.tag,
      required this.location,
      this.type});

  String title;
  String subtitle;
  String image;
  String location;
  String reward;
  EventType? type;
  DateTime? startDate;
  DateTime? endDate;
  List<Tag>? tag;

  factory Event.fromJson(Map<String, dynamic> json) {
    NumberFormat formatCurrency = NumberFormat.simpleCurrency(locale: 'ko_KR', name: '');
    return Event(
        type:
            json['type'] != null ? EventType.values.byName(json['type']) : null,
        title: json['title'],
        location: json['location'] != null ? json['location'] : '',
        subtitle: json['subtitle'] != null ? json['subtitle'] : '',
        reward: json['reward'] != null ? formatCurrency.format(json['reward']) : '',
        image: json['image'],
        startDate: json['start_date'] != null
            ? DateTime.parse(json['start_date'])
            : null,
        endDate: json['start_date'] != null
            ? DateTime.parse(json['end_date'])
            : null,
        tag: json['tag'] != null
            ? (List.from(json['tag'])).map((tag) => Tag.fromJson(tag)).toList()
            : null);
  }
  
}
