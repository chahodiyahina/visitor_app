import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/endpoint_constant.dart';
import 'package:visitor_app/constant/local_storage_services.dart';
import 'package:visitor_app/constant/storage_key_constant.dart';
import 'package:visitor_app/screen/screens/login_screen/login_model.dart';
import 'package:visitor_app/services/http_services.dart' show HttpServices;
import 'package:visitor_app/utils/navigation.dart';
import 'package:visitor_app/widget/custom_loading_dialog.dart';
import 'package:visitor_app/widget/custom_toast.dart';

class LoginControllar extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  LoginModel loginModel = LoginModel();

  Future<void> postLogin(BuildContext context) async {
    try {
      FocusManager.instance.primaryFocus!.unfocus();
      customLoadingDialog();

      final response = await HttpServices.postFormUrlEncoded(
        url: ApiEndPoint.login,
        body: {
          "email": emailController.text.trim(),
          "password": passController.text.trim(),
        },
      );
      log("postLogin response ::: ${response['body']}");
      if (response['error_description'] == null) {
        loginModel = loginModelFromJson(response['body']);
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.token, stringData: loginModel.accessToken);
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.boolType, prefKey: LocalStorageKey.isLogin, boolData: true);
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.integerType, prefKey: LocalStorageKey.id, integerData: loginModel.user?.id );
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.email, stringData: loginModel.user?.email);
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.name, stringData: loginModel.user?.name);
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.userType, stringData: loginModel.user?.userType??"");
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.gateNo, stringData: loginModel.user?.siteGateNumber??"")
        ;await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.department, stringData: loginModel.user?.department ?? "");
        await LocalStorageServices.setDataToLocalStorage(
            dataType: LocalStorageKey.stringType, prefKey: LocalStorageKey.site, stringData: loginModel.user?.userSite??"");
        Get.offAllNamed(Routes.dashboardView);
        CustomToast.successToast(message: loginModel.message ?? "", context: context);
      } else {
        final decodedBody = jsonDecode(response['body']);
        customHideLoadingDialog();
        CustomToast.errorToast(message:decodedBody['message'], context: context);
        log("LOGIN FAILED ::: ${response['error_description']}");
      }
    } catch (e,st) {
      customHideLoadingDialog();
      log("LOGIN ERROR ::: $e === $st");
    }
  }

}