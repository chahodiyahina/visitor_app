import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:visitor_app/splash_screen/splash_controllar.dart';

class InternetService {
  static late StreamSubscription _subscription;

  static void start() {
    _subscription =
        Connectivity().onConnectivityChanged.listen((result) async {

          if (result == ConnectivityResult.none) {
            Get.snackbar(
              "No Internet",
              "Please check your connection",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(days: 1),
            );
          } else {
            // Real internet check
            final hasInternet = await _realInternet();

            if (hasInternet) {
              // _splashController.openScreen();
            }
          }
        });
  }

  static Future<bool> _realInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  static void stop() {
    _subscription.cancel();
  }
}
