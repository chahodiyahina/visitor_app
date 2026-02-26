import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/local_storage_services.dart';
import 'package:visitor_app/constant/storage_key_constant.dart';
import 'package:visitor_app/utils/navigation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    start();
    // openScreen();
    super.onInit();
  }

  static openScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    bool isLogin = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.boolType,
            prefKey: LocalStorageKey.isLogin) ??
        false;
    log("is login local:-$isLogin");
    if (isLogin == true) {
      Get.offAllNamed(Routes.dashboardView);
    } else {
      Get.offAllNamed(Routes.loginScreen);
    }
    // Get.offAllNamed(Routes.dashboardView);
  }

  /// internet connectivity checker
  static late StreamSubscription _subscription;

  static void start() {
    _subscription = Connectivity().onConnectivityChanged.listen((_) async {
      final hasInternet = await _hasRealInternet();

      log("HAS INTERNET: $hasInternet");

      if (!hasInternet) {
        Get.toNamed(Routes.noInternetScreen);
      } else {
        openScreen(); // or restart app
      }
    });
  }

  static Future<bool> _hasRealInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  static void stop() {
    _subscription.cancel();
  }
}
