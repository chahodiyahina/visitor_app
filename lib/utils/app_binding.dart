import 'package:get/get.dart';
import 'package:visitor_app/splash_screen/splash_controllar.dart';
class AppBidding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
