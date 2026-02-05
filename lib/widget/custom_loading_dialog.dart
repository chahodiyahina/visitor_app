import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/constant/app_images.dart';
import 'package:visitor_app/utils/size_utils.dart';

void customLoadingDialog({BuildContext? context}) {
  Future.delayed(const Duration(milliseconds: 0), () {
    showDialog(
        context: context ?? Get.context!,
        barrierDismissible: false,
        barrierColor: AppColors.transparentColor,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Center(
                child: Material(
              color: AppColors.transparentColor,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Lottie.asset(AppImage.loader,
                    height: SizeUtils.verticalBlockSize * 18,
                    width: SizeUtils.verticalBlockSize * 18),
                Text("Loading...",
                    style: TextStyle(fontSize: SizeUtils.fSize_18()))
              ]),
            )),
          );
        });
  });
}

void customHideLoadingDialog({BuildContext? context}) => Get.back();
