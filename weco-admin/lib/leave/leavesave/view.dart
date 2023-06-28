import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

import '../../tool/theme.dart';

class LeaveSaveView extends XView<LeaveSaveController> {
  LeaveSaveView(args, LeaveSaveController controller)
      : super(args, controller) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 610.h,
              width: 610.w,
              // color: Colors.black,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //头像
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
                    // type 选项栏
                    Container(
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Obx(
                            () => Container(
                              width: 250.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 5.r),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10.h),
                                border:
                                    Border.all(color: Colors.white, width: 2.h),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.selectedValue.value.isEmpty
                                      ? null
                                      : controller.selectedValue
                                          .value, // 确保 selectedValue 不为空
                                  hint: Text(
                                    "Select  option",
                                    style: TextStyle(color: Colors.white, fontSize: 22.sp),
                                  ),
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 25.r),
                                    child: const Icon(Icons.arrow_downward),
                                  ),
                                  iconSize: 24.sp,
                                  elevation: 16,
                                  dropdownColor: Colors.white,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    controller.selectedValue.value = newValue!;
                                  },
                                  items: <String>[
                                    'Option 1',
                                    'Option 2',
                                    'Option 3',
                                    'Option 4',
                                    'Option 5'
                                  ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 日期Debut
                    Container(
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Debut',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Obx(
                            () => Container(
                              width: 250.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 5.r),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10.h),
                                border:
                                    Border.all(color: Colors.white, width: 2.h),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy - hh:mm').format(
                                        controller.selectedDateDebut.value),
                                    style: TextStyle(fontSize: 22.sp),
                                  ),
                                  // IconButton(
                                  //   icon: Icon(Icons.calendar_today),
                                  //   onPressed: () async {
                                  //     final date = await showDatePicker(
                                  //       context: context,
                                  //       initialDate: DateTime.now(),
                                  //       firstDate: DateTime(1900),
                                  //       lastDate: DateTime(2100),
                                  //     );
                                  //     // ignore: use_build_context_synchronously
                                  //     final time = await showTimePicker(
                                  //       context: context,
                                  //       initialTime: TimeOfDay.now(),
                                  //     );
                                  //     if (date != null && time != null) {
                                  //       controller.selectedDateDebut.value =
                                  //           DateTime(
                                  //         date.year,
                                  //         date.month,
                                  //         date.day,
                                  //         time.hour,
                                  //         time.minute,
                                  //       );
                                  //     }
                                  //   },
                                  // ),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (date != null && time != null) {
                                        controller.calculateDebutDifference(
                                            date, time);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 日期Fin
                    Container(
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fin',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Obx(
                            () => Container(
                              width: 250.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 5.r),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10.h),
                                border:
                                    Border.all(color: Colors.white, width: 2.h),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy - hh:mm').format(
                                        controller.selectedDateFin.value),
                                    style: TextStyle(fontSize: 22.sp),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                    if (date != null && time != null) {
                                        controller.calculateFinDifference(
                                            date, time);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 时间差
                    Container(
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Minutes de vacances',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            width: 250.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.h, vertical: 5.r),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.h),
                              border:
                                  Border.all(color: Colors.white, width: 2.h),
                            ),
                            child: Obx(
                              () => Text(
                                '${controller.dateDifference.value.inMinutes} minutes',
                                style: TextStyle(fontSize: 22.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
