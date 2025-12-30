import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitor_app/constant/app_images.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      body: Container(
        height: SizeUtils.screenHeight,
        width: SizeUtils.screenWidth,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImage.logo,height: SizeUtils.verticalBlockSize * 15,width: SizeUtils.horizontalBlockSize * 15),
           SizedBox(height: SizeUtils.verticalBlockSize * 2),
            CustomText(
              title: AppString.appName,
              fontSize: SizeUtils.fSize_22(),
              fontWeight: FontWeight.w800,
            )
          ],
        ),
      ),
    );
  }
}
