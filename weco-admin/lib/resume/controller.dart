import 'dart:async';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

class OvertimeController extends GetxController {
   ValueNotifier<dynamic> result = ValueNotifier(null);
  RxBool cardReadError = RxBool(false);
  Timer? _timer;
  late FlutterTts flutterTts;
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
    startNfcSession();
  }

  Future speak(String text) async {
    // 修改为实例函数
    await flutterTts.setLanguage("fr-FR"); // 设置语言
    await flutterTts.setPitch(1); // 设置语调
    await flutterTts.setSpeechRate(0.5); // 设置语速
    await flutterTts.speak(text); // 要播报的文本内容
  }

  void startNfcSession() {
    speak('$message');
    _timer = Timer(const Duration(seconds: 3), () {
      Get.offAllNamed('/home');
    });
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      _timer?.cancel();
      speak('$message');
      _timer = Timer(const Duration(seconds: 3), () {
        Get.offAllNamed('/home');
      });

      result.value = tag.data;
      if (tag != null &&
          tag.data != null &&
          tag.data.containsKey('mifareclassic') &&
          tag.data['mifareclassic'] != null &&
          tag.data['mifareclassic'].containsKey('identifier') &&
          tag.data['mifareclassic']['identifier'] != null) {
        var uid = hex
            .encode(tag.data['mifareclassic']['identifier'].reversed.toList());
        uid = int.tryParse(uid, radix: 16).toString();
        uid = uid.padLeft(10, '0');
        cardReadError.value = false;
      } else {
        cardReadError.value = true;
      }

      if (cardReadError.value) {
        // 只有当卡片读取错误时，才显示 Snackbar
        Get.snackbar(
          'error_title'.tr,
          'error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.error, color: Colors.white),
        );
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel(); // 在控制器关闭时取消操作
  }



  // 玩的
  // List<String> imageList = [
  //   'assets/images/love_1.jpeg',
  //   'assets/images/love_2.jpeg',
  //   'assets/images/love_3.jpeg',
  //   'assets/images/love_4.jpeg',
  //   'assets/images/love_5.jpeg',
  // ];



  // late final PageController pageController;
  // Timer? timer;

  // @override
  // void onInit() {
  //   super.onInit();

  //   pageController = PageController(initialPage: 0);

  //   timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
  //     if (pageController.page!.toInt() == imageList.length - 1) {
  //       pageController.animateToPage(
  //         0,
  //         duration: Duration(milliseconds: 800),
  //         curve: Curves.easeInOut,
  //       );
  //     } else {
  //       pageController.nextPage(
  //         duration: Duration(milliseconds: 800),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  // }

  // @override
  // void onClose() {
  //   timer?.cancel();
  //   pageController.dispose();
  //   super.onClose();
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }
}
