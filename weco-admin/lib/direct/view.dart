import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

import '../tool/theme.dart';

class ResultView extends XView<ResultController> {
  ResultView(args, ResultController controller) : super(args, controller) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Center(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Container(
                        height: 140.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor,
                            width: 8.h,
                          ),
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: 130.w,
                            height: 130.h,
                            child: Image.network(
                              controller.avatarUser.isNotEmpty
                                  ? controller.avatarUser
                                  : 'assets/images/useravatar.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 100.r, top: 80.r),
                        child: Text(
                          "${controller.message}",
                          style:
                              TextStyle(fontSize: 80.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 350.h, // set the height
                    width: 350.w, // set the width
                    child: const Image(
                      image: AssetImage('assets/images/good-night.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
