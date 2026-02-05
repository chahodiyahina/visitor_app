import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/screen/screens/login_screen/login_controllar.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/navigation.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/utils/validation.dart';
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginControllar _loginController = Get.put(LoginControllar());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 4),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeUtils.verticalBlockSize * 22),
                  Center(
                    child: CustomText(
                        title: AppString.appName,
                        fontSize: SizeUtils.fSize_25(),
                        fontWeight: FontWeight.w800),
                  ),
                  Center(
                    child: CustomText(
                        color: AppColors.grey80,
                        title: "Sign in",
                        fontSize: SizeUtils.fSize_18(),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: SizeUtils.verticalBlockSize * 1),
                  CustomText(
                      color: AppColors.grey80,
                      title: "Enter credentials to access dashboard",
                      fontSize: SizeUtils.fSize_16(),
                      fontWeight: FontWeight.w600),
                  SizedBox(height: SizeUtils.verticalBlockSize * 1),
                  CustomText(
                      color: AppColors.black11A,
                      title: AppString.email,
                      fontSize: SizeUtils.fSize_16(),
                      fontWeight: FontWeight.w600),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeUtils.horizontalBlockSize * 1,
                        bottom: SizeUtils.verticalBlockSize * 2.6),
                    child: CustomTextField(
                      controller: _loginController.emailController,
                      hintText: "Enter your email",
                      hintColor: AppColors.grey80,
                      validator: AppValidator.emailValidator,
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: AppColors.greyA6),
                    ),
                  ),
                  CustomText(
                      color: AppColors.black11A,
                      title: AppString.pass,
                      fontSize: SizeUtils.fSize_16(),
                      fontWeight: FontWeight.w600),
                  CustomTextField(
                      controller: _loginController.passController,
                      hintText: "Enter your password",
                      hintColor: AppColors.grey80,
                      validator: AppValidator.emptyField,
                      prefixIcon:
                          const Icon(Icons.lock_outlined, color: AppColors.grey80),
                      isPassword: true),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeUtils.verticalBlockSize * 2.6),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                            color: AppColors.black11A,
                            title: AppString.fPass,
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w600)),
                  ),
                  CustomButton(
                      title: AppString.signIn,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                       await   _loginController.postLogin(context);
                        }
                        log("hello");
                      },
                      textColor: AppColors.whiteColor),
                  SizedBox(height: SizeUtils.verticalBlockSize * 2),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              color: AppColors.grey80,
                              fontSize: SizeUtils.fSize_14()),
                          children: const [
                            TextSpan(
                              text: "Contact your administrator",
                              style: TextStyle(color: AppColors.black11A),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
