import 'dart:async';

import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nfc_manager/nfc_manager.dart';

mixin NfcSessionMixin on GetxController {
  Timer? _timer;
  ValueNotifier<dynamic> result = ValueNotifier(null);
  RxBool cardReadError = RxBool(false);
  late FlutterTts flutterTts;

  Future speak(String text) async {
    await flutterTts.setLanguage("fr-FR");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  void startNfcSession(String message) {
    speak(message);
    _timer = Timer(const Duration(seconds: 3), () {
      Get.offAllNamed('/home');
    });

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      _timer?.cancel();
      speak(message);
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
    _timer?.cancel();
  }
}
