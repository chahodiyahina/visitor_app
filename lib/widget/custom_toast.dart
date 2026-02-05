import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/size_utils.dart';

class CustomToast {
  static successToast({required String message, BuildContext? context}) {
    customToast(
        context: context,
        title: 'Success',
        message: message,
        bgColor: AppColors.successToastBgColor,
        sideBarColor: AppColors.successToastSideColor,
        icon: Icons.check_circle_outline);
  }

  static warningToast({required String message, BuildContext? context}) {
    customToast(
        context: context,
        title: 'Warning',
        message: message,
        bgColor: AppColors.warningToastBgColor,
        sideBarColor: AppColors.warningToastSideColor,
        icon: Icons.warning_rounded);
  }

  static errorToast({required String message, BuildContext? context}) {
    customToast(context: context, title: 'Error', message: message);
  }

  static infoToast({required String message, BuildContext? context}) {
    customToast(
        context: context,
        title: 'Information',
        message: message,
        bgColor: AppColors.infoToastBgColor,
        sideBarColor: AppColors.infoToastSideColor,
        icon: Icons.info);
  }

  static customToast(
      {required String message,
      BuildContext? context,
      IconData? icon,
      Color? bgColor,
      Color? sideBarColor,
      required String title}) {
    MotionToast(
      width: MediaQuery.of(context ?? Get.context!).size.width * 0.75,
      height: MediaQuery.of(context ?? Get.context!).size.height * 0.10,
      icon: icon ?? Icons.error,
      contentPadding: const EdgeInsets.only(right: 6),
      toastAlignment: Alignment.bottomCenter,
      primaryColor: bgColor ?? AppColors.errorToastBgColor,
      secondaryColor: sideBarColor ?? AppColors.errorToastSideColor,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
      ),
      dismissable: false,
      description: Text(
       message, style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16), ),
    ).show(context ?? Get.context!);
  }
}
