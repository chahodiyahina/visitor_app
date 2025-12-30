import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/constant/app_images.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_text.dart';

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
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
              border: Border.all(color: AppColors.whiteColor,width: 4),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    spreadRadius: 8,
                    offset: const Offset(0, 0)),
              ],
            ),
            child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.asset(AppImage.profile,fit: BoxFit.fill,)),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 2),
          child: CustomText(
            title: "Rashmin Kumar",
            fontSize: SizeUtils.fSize_16(),
            fontWeight: FontWeight.w800,
          ),
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
                    text: "9900990099",
                    style: TextStyle(
                        fontSize: SizeUtils.fSize_12(),
                        color: AppColors.grey80))
              ]),
        ),
        RichText(
          text: TextSpan(
              text: "Badge:",
              style: TextStyle(
                  fontSize: SizeUtils.fSize_12(),
                  color: AppColors.black11A,
                  fontWeight: FontWeight.w800),
              children: [
                TextSpan(
                    text: "444",
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
            child: Column(children: [
              customRow(),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.verticalBlockSize * 2),
                  child: customRow(
                      title1: "Gate Number",
                      title2: "Check-in Time",
                      subTitle1: "3",
                      subTitle2: "12:14 PM")),
              customRow(
                  title1: "Check-out Time",
                  title2: "",
                  subTitle1: "10:10",
                  subTitle2: ""),
              customContainer(
                child: Column(children: [
                  customRow(
                      title1: "Vehicle Number",
                      title2: "Vehicle Type",
                      subTitle1: "Gj16ay3334",
                      subTitle2: "Truck"),
                  SizedBox(height: SizeUtils.verticalBlockSize * 2),
                  customRow(
                      title1: "Item Type",
                      title2: "Items Count",
                      subTitle1: "Bitvmen darm bathi bokat",
                      subTitle2: "12"),
                ]),
              ),
            customContainer(
                child:CustomText(title: "Present this pass at security when exiting premises.",))
            ]),
          ),
        )
      ]),
    );
  }

  Widget customRow(
      {String? title1, String? subTitle1, String? title2, String? subTitle2}) {
    return Row(children: [
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
            title: subTitle2 ?? "Gopin Semicon",
            fontSize: SizeUtils.fSize_12(),
            color: AppColors.black11A,
            fontWeight: FontWeight.w800,
          ),
        ]),
      )
    ]);
  }
  Widget customContainer({required Widget child}){
    return  Container(
        margin: EdgeInsets.symmetric(
            vertical: SizeUtils.verticalBlockSize * 2),
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 4,
            vertical: SizeUtils.verticalBlockSize * 2),
        decoration: BoxDecoration(
            color: AppColors.greyA6.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border:
            Border.all(color: AppColors.grey80.withOpacity(0.2))),
      child: child
    );
  }
}
