import 'dart:developer';

import 'package:get/get.dart';
import 'package:visitor_app/constant/local_storage_services.dart';
import 'package:visitor_app/constant/storage_key_constant.dart';
import 'package:visitor_app/utils/navigation.dart';

class SplashController extends GetxController{


  @override
  void onInit() {
    openScreen();
    super.onInit();
  }

  openScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    bool isLogin = await LocalStorageServices.getDataFromLocalStorage(
        dataType: LocalStorageKey.boolType, prefKey: LocalStorageKey.isLogin) ?? false;
    log("is login local:-$isLogin");
    if(isLogin == true){
      Get.offAllNamed(Routes.dashboardView);
    }else{
    Get.offAllNamed(Routes.loginScreen);
    }
    // Get.offAllNamed(Routes.dashboardView);
  }



}