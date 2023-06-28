import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../tool/nfcsession.dart';

class OutController extends GetxController with NfcSessionMixin {
  var message = [].obs;
  String avatarUser = '';

  @override
  void onInit() {
    super.onInit();
    flutterTts = FlutterTts();
    Map<String, dynamic> args = Get.arguments;
    avatarUser = args['avatarUser'].toString();
    if (Get.arguments['message'] is List<dynamic>) {
      message.assignAll(Get.arguments['message'].cast<String>());
    } else {
      message.assignAll([Get.arguments['message']]);
    }
    startNfcSession((message.value).join(''));
  }
}
