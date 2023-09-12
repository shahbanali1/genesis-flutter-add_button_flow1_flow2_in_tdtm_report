import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/constants/app_colors.dart';

class CommonUtils {
  DateTime selectedDate = DateTime.now();
  showDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  showLoaderDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 8.0), child: Text(message)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String checkPlatformType() {
    if (Platform.isAndroid) {
      return "A";
    }
    return "I";
  }

  static Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static String getCurrentMonth() {
    return DateFormat.MMMM().format(DateTime.now());
  }

  static bool notNullParams(String stringValue) {
    if (stringValue.isEmpty ||
        stringValue == "" ||
        stringValue == "-" ||
        stringValue.length < 1) {
      return false;
    }
    return true;
  }

  static List<Color> colorsList = [
    AppColors.colorCorporate,
    AppColors.colorHotspot,
    AppColors.colorRetail,
    AppColors.colorDirectOrder,
    AppColors.colorDragon,
    AppColors.colorWeb,
    AppColors.colorApp,
    AppColors.colorHealthManger,
    AppColors.colorInbound,
    AppColors.colorPhlebotomist,
    AppColors.colorInbound_google,
    AppColors.colorInbound_jd,
    AppColors.colorInbound_exist,
    AppColors.colorInbound_sms,
    AppColors.mdtp_done_disabled_dark,
    AppColors.colorYellowLt,
    AppColors.colorYellowDk,
  ];

  static String getSubstractedMonthDate(DateTime now, int monthsToSubstract) {
    DateTime substracted =
        DateTime(now.year, now.month - monthsToSubstract, now.day);
    return "${substracted.toLocal()}".split(' ')[0];
  }

  showSnackBar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
