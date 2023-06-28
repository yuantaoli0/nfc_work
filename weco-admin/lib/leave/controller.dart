import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:sdk/models/terminal.dart';

class LeaveConfirmationController extends GetxController {
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
    startNfcSession();
  }

  void startNfcSession() {
    //如果没有任何操作30秒后跳转到home
    _timer = Timer(const Duration(seconds: 30), () {
      Get.offAllNamed('/home');
    });
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      _timer?.cancel(); // 取消定时器 进入下一个页面
      result.value = tag.data;

      Terminal terminal = Terminal(tag.data);

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

        //读取打卡num
        if (tag != null &&
            tag.data != null &&
            tag.data.containsKey('mifareclassic') &&
            tag.data['mifareclassic'] != null &&
            tag.data['mifareclassic'].containsKey('identifier') &&
            tag.data['mifareclassic']['identifier'] != null) {
          var uid = hex.encode(
              tag.data['mifareclassic']['identifier'].reversed.toList());
          uid = int.tryParse(uid, radix: 16).toString();
          uid = uid.padLeft(10, '0');
          //读取后台打卡信息
          var punchCardResult = await terminal.punchCard(uid, "");
          var data = punchCardResult['data'];

          var avatarUser = data['employe']['avatarUrl'].toString();

          Get.toNamed(
            '/leavesave',
            arguments: {'avatarUser': avatarUser},
          );
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
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel(); // 在控制器关闭时取消操作
  }
}
