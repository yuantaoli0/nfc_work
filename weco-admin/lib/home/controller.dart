import 'dart:async';
import 'dart:convert';
import 'package:convert/convert.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:sdk/models/terminal.dart';
import 'local.dart';

class HomeController extends GetxController {
  Rx<DateTime> currentTime = Rx<DateTime>(DateTime.now());
  ValueNotifier<dynamic> result = ValueNotifier(null);
  RxBool cardReadError = RxBool(false);

  RxString message = ''.obs;
  RxString avatarUser = ''.obs;

  @override
  void onInit() {
    super.onInit();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = DateTime.now();
    });

    startNfcSession();
  }

  void startNfcSession() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();

      Terminal terminal = Terminal(tag.data);

      //读取打卡num
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
        //读取后台打卡信息
        var punchCardResult = await terminal.punchCard(uid, "");
        message.value = punchCardResult['message'];
        var data = punchCardResult['data'];
        var punchTypes = data['punchTypes'];

        avatarUser.value = data['employe']['avatarUrl'].toString();

        print(punchCardResult);
        print('message--------------$message');
        print('punchedAt--------------$avatarUser');
        print('punchTypes--------------$punchTypes');

        //如果punchTypes是空的跳转到result页面
        if (punchTypes != null && punchTypes.isNotEmpty) {
          Get.toNamed('/option', arguments: {
            'punchTypes': punchTypes,
            'message': message,
            'avatarUser': avatarUser
          });
        } else {
          Get.toNamed('/result',
              arguments: {'message': message, 'avatarUser': avatarUser});
        }
        cardReadError.value = false;
      } else {
        cardReadError.value = true;
        startNfcSession();
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

  void leaveofAbsence() {
    Get.toNamed('/leaveconfirmation');
  }
}
