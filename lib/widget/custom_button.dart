import 'package:flutter/material.dart';
import 'package:visitor_app/constant/app_color.dart';

import '../utils/app_string.dart';
import '../utils/size_utils.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final List<BoxShadow>? boxShadow;
  final double? borderWidth;
  final double? lineHeight;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.buttonColor,
    this.width,
    this.textColor,
    this.borderColor,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.radius,
    this.fontFamily,
    this.boxShadow,
    this.borderWidth,
    this.lineHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {},
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            style: BorderStyle.solid,
            width: borderWidth ?? 1.3,
          ),
          color: buttonColor ?? AppColors.buttonColor,
          borderRadius: BorderRadius.circular(
            radius ?? SizeUtils.horizontalBlockSize * 2,
          ),
          boxShadow: boxShadow,
        ),
        height: height ?? 50,
        width: width ?? SizeUtils.horizontalBlockSize * 100,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: lineHeight??1.1,
              fontFamily: fontFamily ?? AppString.fMontserrat,
              color: textColor,
              fontSize: fontSize ?? SizeUtils.fSize_20(),
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Color? iconColor;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const CustomIconButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.iconColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      constraints: const BoxConstraints(),
      padding: padding ?? EdgeInsets.zero,
      onPressed: onTap,
      icon: child,
      color: iconColor,
    );
  }
}
