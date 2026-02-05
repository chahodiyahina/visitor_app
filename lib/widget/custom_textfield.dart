import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/date_formate.dart' show DateInputFormatter;
import 'package:visitor_app/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int maxLine;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final Color? textColor;
  final double? fontSize;
  final int? maxLength;
  final double? radius;
  final double? latterSpacing;
  final bool isPassword;
  final bool isAutoFocus;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final Color? hintColor;
  final double? hintTextSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final VoidCallback? onTap;
  final Color? enabledBorderColor;
  final Color? disabledBorder;
  final Color? focusedColor;
  final Color? cursorColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixWidget;
  final double? height;
  final double? width;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;
  final bool isNumber;
  final bool readOnly;
  final bool? expand;
  final FontWeight? fontWeight;
  final FontWeight? hintFontWeight;
  final AutovalidateMode? autovalidateMode;
  final String? fontFamily;
  final double? borderWidth;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final int minLines;

  CustomTextField(
      {Key? key,
      this.onChanged,
      this.readOnly = false,
      this.isNumber = false,
      this.maxLine = 1,
      this.maxLength,
      this.radius = 12,
      this.latterSpacing,
      this.fontSize,
      this.fillColor,
      this.textColor,
      this.borderColor,
      this.isPassword = false,
      this.isAutoFocus = false,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.hintText,
      this.labelText,
      this.hintColor,
      this.hintTextSize,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.enabledBorderColor,
      this.disabledBorder,
      this.focusedColor,
      this.cursorColor,
      this.controller,
      this.contentPadding,
      this.prefixWidget,
      this.height,
      this.width,
      this.validator,
      this.textCapitalization,
      this.fontWeight,
      this.hintFontWeight,
      this.fontFamily,
      this.borderWidth,
      this.autovalidateMode,
      this.onFieldSubmitted,
      this.textInputAction,
      this.minLines = 1,
      this.expand})
      : super(key: key);

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isObscure,
      builder: (context, bool isObscure, _) {
        if (!isPassword) {
          isObscure = false;
        }
        return TextFormField(
          style: TextStyle(
            color: textColor ?? AppColors.black11A,
            fontSize: fontSize ?? SizeUtils.fSize_13(),
            letterSpacing: latterSpacing,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? AppString.fMontserrat,
          ),
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          cursorColor: cursorColor ?? Colors.black,
          onTap: onTap,
          minLines: minLines,
          obscureText: isObscure,
          obscuringCharacter: '*',
          autofocus: isAutoFocus,
          onChanged: onChanged,
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          maxLines: maxLine,
          maxLength: maxLength,
          expands: expand ?? false,
          keyboardType: maxLine != 1 ? TextInputType.multiline : keyboardType,
          focusNode: focusNode,
          readOnly: readOnly,
          textAlign: TextAlign.start,
          validator: validator,
          textInputAction: textInputAction,
          inputFormatters: isNumber == true
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  DateInputFormatter()
                ]
              : null,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
            labelText: labelText,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius!)),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.borderColor,
                width: borderWidth ?? 1.8,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius!)),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.borderColor,
                width: borderWidth ?? 1.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focusedColor ?? AppColors.borderColor,
                width: borderWidth ?? 1.8,
              ),
            ),
            prefix: prefixWidget,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            isDense: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon == null && isPassword
                ? IconButton(
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.greyA6,
                    ),
                    splashColor: Colors.transparent,
                    onPressed: () {
                      _isObscure.value = !isObscure;
                    },
                  )
                : suffixIcon,
            counterText: "",
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor ?? AppColors.hintTextColor,
              fontSize: hintTextSize ?? SizeUtils.fSize_13(),
              letterSpacing: latterSpacing,
              fontWeight: hintFontWeight ?? FontWeight.w400,
              fontFamily: fontFamily ?? AppString.fMontserrat,
            ),
            filled: true,
            fillColor: fillColor ?? AppColors.fillColor,
            //?? Colors.grey[200],
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.borderColor,
                width: borderWidth ?? 1.8,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.borderColor,
                width: borderWidth ?? 1.8,
              ),
            ),
          ),
        );
      },
    );
  }
}
