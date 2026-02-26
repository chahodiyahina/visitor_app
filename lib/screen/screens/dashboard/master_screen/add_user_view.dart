import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/master_controller.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/models/masterUser_model.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_dropdown.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final MasterController _masterController = Get.find();
  String getType = "";
  Datum? data;

  @override
  void initState() {
    getType = Get.arguments ?? "";
    if (getType != "add") {
      data = _masterController.masterUserModel.value
          .data?[_masterController.selectedUserIndex.value];
      _masterController.nameController.text = data?.name ?? "";
      _masterController.emailController.text = data?.email ?? "";
      _masterController.selectedRole.value = data?.isSuperuser == true
          ? "Admin"
          : data?.isSecurity == true
              ? "Security"
              : "Staff";
      _masterController.phoneController.text = data?.mobileNumber ?? "";
      _masterController.departmentController.text = data?.department ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    _masterController.clearField();
    super.dispose();
  }

  final List<String> genderItems = ['Admin', "Staff", "Security"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          title: CustomText(
              title: "Add New User",
              fontSize: SizeUtils.fSize_18(),
              fontWeight: FontWeight.bold),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 2),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Name *"),
                    _input(controller: _masterController.nameController),
                    _label("Email *"),
                    _input(
                        hint: "Enter email address",
                        controller: _masterController.emailController,
                        keyboardType: TextInputType.emailAddress),
                    _label("Password *"),
                    _input(
                        controller: _masterController.passController,
                        hint: "Enter password",
                        isPass: true),
                    _label("Role *"),
                    CustomDropdownField(
                      hint: 'Select Role',
                      items: genderItems,
                      value: _masterController.selectedRole.value,
                      onChanged: (value) {
                        _masterController.selectedRole.value = value;
                      },
                      validator: (value) {
                        if (value == null) return 'Please select role.';
                        return null;
                      },
                    ),
                    _label("Phone *"),
                    _input(
                        hint: "Enter 10-digit phone number",
                        controller: _masterController.phoneController,
                        keyboardType: TextInputType.phone),
                    if (_masterController.selectedRole.value != "Security")
                      _label("Department *"),
                    if (_masterController.selectedRole.value != "Security")
                      _input(
                          hint: "Enter department name",
                          controller: _masterController.departmentController),
                    if (_masterController.selectedRole.value == "Security")
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label("Site *"),
                            _input(
                                hint: "Enter site name",
                                controller: _masterController.siteController),
                            _label("Gate Number *"),
                            _input(
                                hint: "Enter gate number",
                                controller: _masterController.getNoController,
                                keyboardType: TextInputType.number),
                          ]),
                    const SizedBox(height: 20),

                    /// Buttons
                    Row(children: [
                      Expanded(
                        child: CustomButton(
                            onTap: () {
                              Get.back();
                              _masterController.clearField();
                            },
                            title: "Cancel",
                            fontSize: SizeUtils.fSize_15(),
                            borderColor: AppColors.black11A,
                            radius: 15,
                            buttonColor: AppColors.whiteColor),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                            onTap: () async {
                              if (getType != "add") {
                                log("update user");
                                await _masterController.updateUser(
                                    name: _masterController.nameController.text,
                                    email:
                                        _masterController.emailController.text,
                                    moNum:
                                        _masterController.phoneController.text,
                                    id: data?.id.toString(),
                                    departMent: _masterController
                                        .departmentController.text,
                                    pass: _masterController.passController.text,
                                    userRole:
                                        _masterController.selectedRole.value);
                              } else {
                                log("add user");
                                _masterController.createUser(context);
                              }
                            },
                            title: "Add User",
                            radius: 15,
                            fontSize: SizeUtils.fSize_15(),
                            textColor: AppColors.whiteColor),
                      ),
                    ]),
                  ]),
            ),
          ),
        ));
  }

  /// Helpers
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: CustomText(
        title: text,
        fontSize: SizeUtils.fSize_14(),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _input(
      {String? hint,
      Widget? child,
      bool? isPass,
      required TextEditingController controller,
      TextInputType keyboardType = TextInputType.text}) {
    return CustomTextField(
      keyboardType: keyboardType,
      controller: controller,
      suffixIcon: child,
      isPassword: isPass ?? false,
      focusedColor: AppColors.black11A,
      hintText: hint ?? "Enter full name",
      fillColor: AppColors.fillColor,
    );
  }
}
