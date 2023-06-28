import 'dart:async';
import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:sdk/models/terminal.dart';

import '../../home/controller.dart';

class LeaveSaveController extends GetxController {
  late FlutterTts flutterTts;
  String avatarUser = '';

  //下拉
  var selectedValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;
    flutterTts = FlutterTts();
    avatarUser = args['avatarUser'].toString();
  }

  Rx<DateTime> selectedDateDebut = DateTime.now().obs;

  Rx<DateTime> selectedDateFin = DateTime.now().obs;

  Rx<Duration> dateDifference = Duration().obs;

  void calculateDebutDifference(DateTime date, TimeOfDay time) {
    DateTime selectedDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    selectedDateDebut.value = selectedDate;
    dateDifference.value =
        selectedDateFin.value.difference(selectedDateDebut.value);
  }

  void calculateFinDifference(DateTime date, TimeOfDay time) {
    DateTime selectedDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    selectedDateFin.value = selectedDate;
    dateDifference.value =
        selectedDateFin.value.difference(selectedDateDebut.value);
  }
}
