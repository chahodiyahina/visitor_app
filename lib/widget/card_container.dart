import 'package:flutter/material.dart';
import 'package:visitor_app/utils/size_utils.dart' show SizeUtils;

class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final double borderRadius;
  final bool showShadow;

  const CardContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.backgroundColor = Colors.white,
    this.borderRadius = 20,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(
    horizontal: SizeUtils.horizontalBlockSize * 3,
        vertical: SizeUtils.horizontalBlockSize * 1),
      padding: padding ??
          EdgeInsets.all(SizeUtils.horizontalBlockSize * 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow
            ? [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ]
            : [],
      ),
      child: child,
    );
  }
}
