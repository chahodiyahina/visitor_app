import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/app_color.dart' show AppColors;
import 'package:visitor_app/utils/size_utils.dart' show SizeUtils;

/*
w100 - thin
w200 - extraLight
w300 - light
w400 - regular
w500 - medium
w600 - semiBold
w700 - bold
w800 - extraBold
w900 - black
 */

class CustomTextStyle {
  static TextStyle title({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.023,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }
  static TextStyle titleF24({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: SizeUtils.fSize_24(),
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.black11A);
  }

  static TextStyle subtitle({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.023,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle semiBold12({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.028,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle bold12({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.028,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle medium12({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.028,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w500);
  }

  static TextStyle semiBold13({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.031,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle medium13({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.031,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w500);
  }

  static TextStyle bold13({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.031,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle semiBold14({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.032,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle bold14({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.032,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle medium14({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.032,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w500);
  }

  static TextStyle semiBold15({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.034,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle medium15({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.034,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w500);
  }

  static TextStyle bold15({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.034,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle regular16({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.037,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w400);
  }

  static TextStyle medium16({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.037,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w500);
  }

  static TextStyle semiBold16({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.037,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle bold16({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.037,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle semiBold17({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.038,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle semiBold18({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.042,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle medium18({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.042,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w500);
  }

  static TextStyle bold18({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.042,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle bold20({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.046,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle semiBold20({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.046,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle semiBold22({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.051,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle bold22({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.051,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle black24({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.040,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w900);
  }

  static TextStyle semiBold26({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.056,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle bold62({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.062,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle semiBold28({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.065,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle black32({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.056,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w700);
  }

  static TextStyle semiBold34({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.100,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w600);
  }

  static TextStyle black36({Color? color}) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: Get.width * 0.084,
        color: color ?? AppColors.black11A,
        fontWeight: FontWeight.w500);
  }

}
