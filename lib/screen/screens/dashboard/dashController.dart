import 'dart:developer';

import 'package:get/get.dart';
import 'package:visitor_app/constant/local_storage_services.dart';
import 'package:visitor_app/constant/storage_key_constant.dart';

class DashController extends GetxController {
  RxInt dashIndex = 0.obs;
  RxString userName = "Visitor".obs;
  RxString userEmail = "Visitor".obs;
  Rx<int?> userId = Rx(null);
  RxString userType = "".obs;
  RxString site = "".obs;
  RxString getNo = "".obs;
  RxString department = "".obs;
  RxString getUserType = "".obs;

  getLocalStoreData() async {
    userName.value = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.stringType,
            prefKey: LocalStorageKey.name) ??
        "";
    userEmail.value = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.stringType,
            prefKey: LocalStorageKey.email) ??
        "";
    userId.value = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.integerType,
            prefKey: LocalStorageKey.id) ??
        "";
    userType.value = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.stringType,
            prefKey: LocalStorageKey.userType) ??
        "";
    site.value = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.stringType,
            prefKey: LocalStorageKey.site) ??
        "";
    getNo.value = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.stringType,
            prefKey: LocalStorageKey.gateNo) ??
        "";
    department.value = await LocalStorageServices.getDataFromLocalStorage(
            dataType: LocalStorageKey.stringType,
            prefKey: LocalStorageKey.department) ??
        "";

    userType.refresh();
    site.refresh();
    getNo.refresh();
    department.refresh();
    log("get all data of user:-$userName == $userType == $site == $department == $userEmail ===$userId");

    getUserType.value = checkUserType(userType.value);
    log("get final user type = ${getUserType.value}");
  }

  String checkUserType(String userType) {
    switch (userType) {
      case "Admin":
        return "Admin";

      case "Staff":
        return "Staff";

      case "Security":
        return "Security";

      default:
        return "";
    }
  }
}
