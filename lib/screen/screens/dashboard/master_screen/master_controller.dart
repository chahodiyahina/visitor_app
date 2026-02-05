import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/endpoint_constant.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/models/masterUser_model.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/models/vehicle_model.dart';
import 'package:visitor_app/services/http_services.dart';
import 'package:visitor_app/widget/custom_loading_dialog.dart';

class MasterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();

  Rx<String?> selectedRole = Rx<String?>(null);
  Rx<int> selectedUserIndex = 0.obs;
  Rx<int> selectedTabIndex = 0.obs;
  RxBool showPassword = false.obs;
  bool isFirstApiCall = true;
  bool isFirstApiCallVehicle = true;
  Rx<MasterUserModel> masterUserModel = MasterUserModel().obs;
  Rx<VehicleModel> vehicleModel = VehicleModel().obs;

  clearField() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passController.clear();
    departmentController.clear();
    selectedRole.value = "";
  }

  Future getMasterScreenData() async {
    try {
      if (isFirstApiCall) {
        customLoadingDialog();
      }
      var response =
          await HttpServices.getHttpMethod(url: ApiEndPoint.getMasterUserData);
      // log("Get getMasterScreenData response data ::: ${response['body']} ");
      masterUserModel.value = masterUserModelFromJson(response['body']);
      log("Get getMasterScreenData response data ::: ${masterUserModel.value.toJson()} ");
      if (isFirstApiCall) {
        customHideLoadingDialog();
        isFirstApiCall = false;
      }
    } catch (e, st) {
      if (isFirstApiCall) {
        customHideLoadingDialog();
        isFirstApiCall = false;
      }
      log("getMasterScreenData get erro $e === $st ====");
    }
  }

  Future getVehicleData() async {
    try {
      if (isFirstApiCallVehicle) {
        customLoadingDialog();
      }
      var response =
          await HttpServices.getHttpMethod(url: ApiEndPoint.getVehicleData);
      // log("Get getMasterScreenData response data ::: ${response['body']} ");
      vehicleModel.value = vehicleModelFromJson(response['body']);
      log("Get getVehicleData response data ::: ${vehicleModel.value.toJson()} ");
      if (isFirstApiCallVehicle) {
        customHideLoadingDialog();
        isFirstApiCallVehicle = false;
      }
    } catch (e, st) {
      if (isFirstApiCallVehicle) {
        customHideLoadingDialog();
        isFirstApiCallVehicle = false;
      }
      log("getVehicleData get erro $e === $st ====");
    }
  }

  Future updateUserActive({String? id, bool? isActive}) async {
    try {
      Map<String, dynamic> data = {"is_active": isActive ?? false};
      var response = await HttpServices.putHttpMethod(
          url: ApiEndPoint.updateUserActive + (id ?? ""), data: data);
      log("Get updateUserActive response data ::: ${response['body']} ");
    } catch (e, st) {
      log("updateUserActive get erro $e === $st ====");
    }
  }

  Future createUser() async {
    try {
      Map<String, dynamic> data = {
        "department": departmentController.text.trim(),
        "email": emailController.text.trim(),
        "mobileNumber": phoneController.text.trim(),
        "name": nameController.text.trim(),
        "password": passController.text.trim(),
        "userrole": selectedRole.value
      };
      var response = await HttpServices.postHttpMethod(
          url: ApiEndPoint.createUser, data: data);
      log("createUser response data ::: ${response['body']} ");
      if (response['error_description'] == null) {
        log("createUser SUCCESS ::: ${response['body']}");
        await getMasterScreenData();
      } else {
        log("createUser FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("createUser erro $e === $st ====");
    }
  }

  Future updateUser(
      {String? id,
      String? name,
      String? email,
      String? pass,
      String? userRole,
      String? moNum,
      String? departMent}) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": pass ?? "",
        "userrole": userRole,
        "mobileNumber": moNum,
        "name": name,
        "department": departMent
      };
      log("payload data:-- $data");
      var response = await HttpServices.putHttpMethod(
          url: ApiEndPoint.updateUser + (id ?? ""), data: data);
      log("updateUser response data ::: ${response['body']} ");
      if (response['error_description'] == null) {
        log("updateUser SUCCESS ::: ${response['body']}");
        await getMasterScreenData();
      } else {
        log("updateUser FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("updateUser get erro $e === $st ====");
    }
  }

  Future createVehicle() async {
    try {
      Map<String, dynamic> data = {
        "vehicleType": vehicleController.text.trim(),
      };
      var response = await HttpServices.postHttpMethod(
          url: ApiEndPoint.createVehicleData, data: data);
      log("createVehicle response data ::: ${response['body']} ");
      if (response['error_description'] == null) {
        log("createVehicle SUCCESS ::: ${response['body']}");
        await getVehicleData();
      } else {
        log("createVehicle FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("createVehicle erro $e === $st ====");
    }
  }

  Future deleteVehicle({required String id}) async {
    try {
      var response = await HttpServices.deleteHttpMethod(
          url: ApiEndPoint.deleteVehicleData + id);
      log("deleteVehicle response data ::: ${response['body']} ");
      if (response['error_description'] == null) {
        log("deleteVehicle SUCCESS ::: ${response['body']}");
        await getVehicleData();
      } else {
        log("deleteVehicle FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("deleteVehicle erro $e === $st ====");
    }
  }

  Future updateVehicleData({String? id}) async {
    try {
      Map<String, dynamic> data = {
        "id": id,
        "vehicleType": vehicleController.text.trim()
      };
      var response = await HttpServices.putHttpMethod(
          url: ApiEndPoint.updateVehicleData, data: data);
      log("Get updateVehicleData response data ::: ${response['body']} ");
      if (response['error_description'] == null) {
        log("updateVehicleData SUCCESS ::: ${response['body']}");
        await getVehicleData();
      } else {
        log("updateVehicleData FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("updateVehicleData get erro $e === $st ====");
    }
  }
}
