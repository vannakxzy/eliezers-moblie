import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../domain/entities/bible_content_entity.dart';

class BibleController extends GetxController {
  final List<BibleContentEntity> bible = <BibleContentEntity>[].obs;

  void getBible(List<BibleContentEntity> data) {
    bible.assignAll(data);
    debugPrint("bible  ${bible.length}");
  }
}
