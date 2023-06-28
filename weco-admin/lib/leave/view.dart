import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

import '../tool/theme.dart';

class LeaveConfirmationView extends XView<LeaveConfirmationController> {
  LeaveConfirmationView(args, LeaveConfirmationController controller)
      : super(args, controller) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0.sign),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40.h,
              ),
              onPressed: () {
                Get.offAllNamed('/home');
              },
            ),
          ),
          Center(
            child: Text(
              'check'.tr,
              style: TextStyle(
                  fontSize: 40.h,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Opacity(
              opacity: 0.1, // 透明度为10%
              child: Image.asset(
                'assets/images/weshop_logo.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
