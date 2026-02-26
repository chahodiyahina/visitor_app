import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_cachedImage.dart';

class IdentityImageVIew extends StatefulWidget {
  const IdentityImageVIew({super.key});

  @override
  State<IdentityImageVIew> createState() => _IdentityImageVIewState();
}

class _IdentityImageVIewState extends State<IdentityImageVIew> {
  @override
  RxString img = "".obs;

  @override
  void initState() {
    img.value = Get.arguments;
    log("get arg image:-$img");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            height: SizeUtils.screenHeight/ 2,
            width: SizeUtils.screenWidth,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: CustomCachedImage(imageUrl: img.value, fit: BoxFit.contain),
          ),
        ),
      );
    });
  }
}
