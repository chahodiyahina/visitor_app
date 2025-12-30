import 'package:get/get.dart';
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
    // Get.offAllNamed(Routes.dashboardView);
    Get.offAllNamed(Routes.loginScreen);
  }
}