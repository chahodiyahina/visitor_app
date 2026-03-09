import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/endpoint_constant.dart';
import 'package:visitor_app/screen/screens/dashboard/home_screen/home_mode.dart';
import 'package:visitor_app/services/http_services.dart';
import 'package:visitor_app/services/notification_service.dart';
import 'package:visitor_app/widget/custom_loading_dialog.dart';

class HomeController extends GetxController {
  Rx<HomeModel> homeModel = HomeModel().obs;
  bool isFirstApiCall = true;

  Future getHomeScreenData() async {
    try {
      if (isFirstApiCall) {
        customLoadingDialog();
        await sentFcmToken();
      }
      var response =
          await HttpServices.getHttpMethod(url: ApiEndPoint.getHomeData);
      // log("Get home screen response data ::: ${response['body']} ");
      homeModel.value = homeModelFromJson(response['body']);
      log("Get home screen response data ::: ${homeModel.toJson()} ");
      if (isFirstApiCall) {
        customHideLoadingDialog();
        isFirstApiCall = false;
      }
    } catch (e, st) {
      if (isFirstApiCall) {
        log("message 44: ---$isFirstApiCall");
        customHideLoadingDialog();
        isFirstApiCall = false;
      }
      log("home data get erro $e === $st ====");
    }
  }

  Future<void> updateAppointmentStatusCheckOut(BuildContext context, {String? id}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.updateAppointmentStatusCheckOut,
        data: {"id": id},
      );
      if (response['error_description'] == null) {
        log("updateAppointmentStatusCheckOut SUCCESS ::: ${response['body']}");
        await getHomeScreenData();
      } else {
        log("updateAppointmentStatusCheckOut FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("updateAppointmentStatusCheckOut ERROR ::: $e === $st");
    }
  }
  Future<void> sentFcmToken() async {
    try {
      String getFcmToken = await NotificationService.getToken();
      log("get FCM token:-$getFcmToken");
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.saveFcmToken,
        data: {"token": getFcmToken},
      );
      if (response['error_description'] == null) {
        print("sentFcmToken SUCCESS ::: ${response['body']}");
      } else {
        log("sentFcmToken FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("sentFcmToken ERROR ::: $e === $st");
    }
  }
}
