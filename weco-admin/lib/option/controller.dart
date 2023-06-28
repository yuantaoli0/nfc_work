import 'dart:async';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:sdk/models/terminal.dart';

import 'local.dart';

class OptionController extends GetxController {
  RxInt selectedIndex = RxInt(-1);
  RxBool isImageLoaded = false.obs;
  ValueNotifier<dynamic> result = ValueNotifier(null);

  // 保存选中索引的列表
  List<String> punchTypes = [];
  String punchin = '';

  var message = "".obs;
  var avatarUser = "".obs;

  late List<Function()> buttonActions; // 在这里只声明，不初始化

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> arguments = Get.arguments;
    punchTypes.addAll(arguments['punchTypes'].cast<String>());


    // 从home 传到option 的参数
    message = arguments['message'];
    avatarUser = arguments['avatarUser'];

    buttonActions = [
      () async {
        Get.toNamed('/work',
            arguments: {'message': message, 'avatarUser': avatarUser});
      },
      () async {
        Get.toNamed('/offwork',
            arguments: {'message': message, 'avatarUser': avatarUser});
      },
      () async {
        Get.toNamed('/out',
            arguments: {'message': message, 'avatarUser': avatarUser});
      },
      () async {
        Get.toNamed('/overtime',
            arguments: {'message': message, 'avatarUser': avatarUser});
      },
      () {
        print('Button 5 pressed');
      },
      () {
        print('Button 6 pressed');
      },
      () {
        print('Button 7 pressed');
      },
      () {
        print('Button 8 pressed');
      },
    ];

    translatePunchTypes();
  }

  void translatePunchTypes() {
    final xlocal = XLocal();
    final languageCode = Get.deviceLocale?.languageCode;

    buttonTexts.clear();
    for (int i = 0; i < punchTypes.length; i++) {
      final translatedText =
          xlocal.getTranslation(punchTypes[i], languageCode!);
      buttonTexts.add(translatedText ?? punchTypes[i]);
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void confirmAction() {
    if (selectedIndex.value >= 0 &&
        selectedIndex.value < buttonActions.length) {
      // 将选中的索引添加到 punchTypes 列表
      buttonActions[selectedIndex.value]();
    } else {
      print('Please select a button first.');
    }
  }

  void cancel() {
    Get.offAllNamed('/home');
  }

  // 定义按钮的图标列表
  final List<IconData> buttonIcons = [
    Icons.brightness_high,
    Icons.brightness_4,
    Icons.local_cafe,
    Icons.alarm_add,
    // Icons.favorite,
    Icons.arrow_upward,
    Icons.arrow_downward,
    Icons.arrow_forward,
    Icons.arrow_back,
  ];

  // 定义按钮的文本列表
  final List<String> buttonTexts = [
    '按钮 1',
    '按钮 2',
    '按钮 3',
    '按钮 4',
    '按钮 5',
    '按钮 6',
    '按钮 7',
    '按钮 8',
  ];

  RxInt currentPageIndex = 0.obs; //圆形下标
}

extension ChunkedExtension<E> on List<E> {
  List<List<E>> chunked(int size) {
    return List.generate((length / size).ceil(), (index) {
      int start = index * size;
      int end = start + size;
      return sublist(start, end > length ? length : end);
    });
  }
}
