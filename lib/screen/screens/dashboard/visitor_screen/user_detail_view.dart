import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/constant/app_images.dart';
import 'package:visitor_app/screen/screens/dashboard/dashController.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_controller.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/models/visitor_model.dart';
import 'package:visitor_app/utils/appUtilas.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/navigation.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:get/get.dart';

class UserDetailView extends StatefulWidget {
  UserDetailView({super.key});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  final VisitorController _visitorController = Get.find();
  final DashController _dashController = Get.find();
  VisitorList? data;

  @override
  void initState() {
    String getType = Get.arguments;
    log("get arguments:- $getType");
    if (getType == AppString.visitor) {
      data = _visitorController.visitorModel.value
          .pendingVisitorList?[_visitorController.selectedVisitorIndex.value];
    } else if (getType == AppString.active) {
      data = _visitorController.visitorModel.value
          .activeVisitorList?[_visitorController.selectedVisitorIndex.value];
    } else if (getType == AppString.checkOut) {
      data = _visitorController.visitorModel.value
          .activeVisitorList?[_visitorController.selectedVisitorIndex.value];
    } else {
      data = _visitorController.visitorModel.value
          .historyVisitorList?[_visitorController.selectedVisitorIndex.value];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: CustomText(
            title: "Visitor details",
            fontSize: SizeUtils.fSize_20(),
            fontWeight: FontWeight.bold,
            color: AppColors.black11A),
      ),
      body: Column(children: [
        SizedBox(height: SizeUtils.verticalBlockSize * 2),
        Center(
          child: Container(
            height: SizeUtils.verticalBlockSize * 15,
            width: SizeUtils.verticalBlockSize * 15,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.whiteColor, width: 4),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 8,
                    spreadRadius: 8,
                    offset: const Offset(0, 0)),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: data?.imagePath == null
                    ? Icon(
                        Icons.person_outline,
                        size: SizeUtils.horizontalBlockSize * 20,
                      )
                    : Image.network(
                        data?.imagePath ?? "",
                        fit: BoxFit.fill,
                      )),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 2),
          child: CustomText(
              title: "${data?.name ?? ""} (${(data?.companyName ?? "-")})",
              fontSize: SizeUtils.fSize_16(),
              fontWeight: FontWeight.w800),
        ),
        RichText(
          text: TextSpan(
              text: "Mobile:",
              style: TextStyle(
                  fontSize: SizeUtils.fSize_12(),
                  color: AppColors.black11A,
                  fontWeight: FontWeight.w800),
              children: [
                TextSpan(
                    text: data?.mobileNumber ?? "-",
                    style: TextStyle(
                        fontSize: SizeUtils.fSize_12(),
                        color: AppColors.grey80))
              ]),
        ),
        RichText(
          text: TextSpan(
              text: "Badge: ",
              style: TextStyle(
                  fontSize: SizeUtils.fSize_12(),
                  color: AppColors.black11A,
                  fontWeight: FontWeight.w800),
              children: [
                TextSpan(
                    text: data?.badgeNumber ?? "-",
                    style: TextStyle(
                        fontSize: SizeUtils.fSize_12(),
                        color: AppColors.grey80))
              ]),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: SizeUtils.verticalBlockSize * 2),
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 4,
                vertical: SizeUtils.verticalBlockSize * 2),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, -8)),
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                customRow(
                    subTitle1:
                        "${data?.host ?? "-"} (${data?.department ?? "-"})",
                    subTitle2: data?.entryPlace ?? ""),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeUtils.verticalBlockSize * 2),
                    child: customRow(
                        title1: "Gate Number",
                        title2: "Check-in Time",
                        subTitle1: data?.entryGate,
                        subTitle2: AppUtils.convertTo12Hour(data?.time ?? ""))),
                customRow(
                    title1: "Check-out Time",
                    title2: "",
                    subTitle1: data?.checkoutAt ?? "-",
                    subTitle2: ""),
                customContainer(
                  child: Column(children: [
                    customRow(
                        title1: "Vehicle Number",
                        title2: "Vehicle Type",
                        subTitle1: data?.vehicleNumber ?? "-",
                        subTitle2: data?.vehicleType ?? "-"),
                    SizedBox(height: SizeUtils.verticalBlockSize * 2),
                    customRow(
                        title1: "Item Type",
                        title2: "Items Count",
                        subTitle1: data?.itemTypes ?? "-",
                        subTitle2: data?.numberOfItems ?? "-"),
                  ]),
                ),
                customContainer(
                    child: CustomText(
                  title: "Present this pass at security when exiting premises.",
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (data?.identityProofImage != null)
                      CustomButton(
                          width: SizeUtils.screenWidth / 2.5,
                          title: "View Identification Image",
                          textColor: AppColors.whiteColor,
                          fontSize: SizeUtils.fSize_12(),
                          onTap: () {
                            Get.toNamed(Routes.identityImageVIew,
                                arguments: data?.identityProofImage);
                          }),
                    if (data?.checkoutImage != null &&
                        data?.appointmentStatus == "Check out")
                      CustomButton(
                          width: SizeUtils.screenWidth / 2.5,
                          title: "View Checkout Image",
                          textColor: AppColors.whiteColor,
                          fontSize: SizeUtils.fSize_12(),
                          onTap: () {
                            Get.toNamed(Routes.identityImageVIew,
                                arguments: data?.checkoutImage);
                          }),
                  ],
                )
              ]),
            ),
          ),
        )
      ]),
    );
  }

  Widget customRow(
      {String? title1, String? subTitle1, String? title2, String? subTitle2}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText(
            title: title1 ?? "HOST NAME",
            fontSize: SizeUtils.fSize_11(),
            color: AppColors.grey80,
            fontWeight: FontWeight.w800,
          ),
          CustomText(
            title: subTitle1 ?? "Parth Kumar",
            fontSize: SizeUtils.fSize_12(),
            color: AppColors.black11A,
            fontWeight: FontWeight.w800,
          ),
        ]),
      ),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText(
            title: title2 ?? "SITE NAME",
            fontSize: SizeUtils.fSize_11(),
            color: AppColors.grey80,
            fontWeight: FontWeight.w800,
          ),
          CustomText(
            title: subTitle2 ?? "e name",
            fontSize: SizeUtils.fSize_12(),
            color: AppColors.black11A,
            fontWeight: FontWeight.w800,
          ),
        ]),
      )
    ]);
  }

  Widget customContainer({required Widget child}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 2),
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 4,
            vertical: SizeUtils.verticalBlockSize * 2),
        decoration: BoxDecoration(
            color: AppColors.greyA6.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey80.withOpacity(0.2))),
        child: child);
  }
}
