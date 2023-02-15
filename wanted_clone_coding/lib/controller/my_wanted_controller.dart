import 'package:get/get.dart';

class MyWantedController extends GetxController {
  MyWantedController controller = MyWantedController();

  final List<int> supportSituation = <int>[0, 0, 0];
  final List<String> supportSituationExplain = <String>[
    '지원 완료',
    '서류 통과',
    '최종 합격',
    '불합격'
  ];
}
