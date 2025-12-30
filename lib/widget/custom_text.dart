import 'package:flutter/material.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/app_string.dart' show AppString;
import 'package:visitor_app/utils/size_utils.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? fontFamily;
  final List<Shadow>? shadows;
  final double? letterSpacing;

  const CustomText(
      {Key? key,
        this.title = "",
        this.color,
        this.fontSize,
        this.fontWeight,
        this.lineHeight,
        this.textAlign,
        this.decoration,
        this.overflow,
        this.maxLines,
        this.fontFamily,
        this.letterSpacing,
        this.shadows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: fontFamily ?? AppString.fMontserrat,
        color: color ?? AppColors.black11A,
        fontSize: fontSize ?? SizeUtils.fSize_13(),
        fontWeight: fontWeight ?? FontWeight.w500,
        height: lineHeight,
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows ??
            [const Shadow(color: Colors.transparent, offset: Offset(0, 0))],
      ),
    );
  }
}
