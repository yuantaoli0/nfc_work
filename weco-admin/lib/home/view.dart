import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

import '../tool/theme.dart';

class HomeView extends XView<HomeController> {
  HomeView(args, HomeController controller) : super(args, controller) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GetBuilder<HomeController>(
                      init: HomeController(),
                      builder: (controller) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor,
                                border: Border.all(
                                  color: SecondaryColor,
                                  width: 10.w,
                                ),
                              ),
                              child: Center(
                                child: Obx(() {
                                  return Text(
                                    '${controller.currentTime.value.hour}:${controller.currentTime.value.minute}:${controller.currentTime.value.second}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Text(
                      'NFC',
                      style: TextStyle(fontSize: 80.sp, color: Colors.white),
                    ),
                    Container(
                      width: 660.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor,
                        border: Border.all(
                          color: SecondaryColor,
                          width: 10.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'clock_login'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.r, top: 50.h),
                  child: Container(
                    width: 200.w,
                    height: 80.h,
                    child: TextButton.icon(
                      onPressed: () {
                        ctl.leaveofAbsence();
                      },
                      icon: const Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      label: Text(
                        'absence'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        side: BorderSide(
                          color: SecondaryColor, // 边框颜色
                          width: 5.h, // 边框宽度
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SvgPicture.asset(
                    'assets/icons/nfc_logo.svg',
                    width: 500.w,
                    height: 500.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
