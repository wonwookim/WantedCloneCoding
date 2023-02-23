import 'package:flutter/cupertino.dart';

enum ScreenState { normal, loading, disconnect, error, success }

enum Screen {
  home(''),
  employment(''),
  community('커뮤니티'),
  myInfo('내 정보'),
  myWanted('My 원티드');

  final String name;
  const Screen(this.name);
}

List<Map<String, dynamic>> tag_json = [
    {'tag_id': 0, 'tag': 'IT/기술'},
    {'tag_id': 1, 'tag': '개발'},
    {'tag_id': 2, 'tag': '커리어고민'},
    {'tag_id': 3, 'tag': '취업/이직'},
    {'tag_id': 4, 'tag': '데이터'},
    {'tag_id': 5, 'tag': '회사생활'},
    {'tag_id': 6, 'tag': 'HR'},
    {'tag_id': 7, 'tag': '마케팅'}
  ];