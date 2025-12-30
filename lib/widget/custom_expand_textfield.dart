import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/size_utils.dart';


OutlineInputBorder outlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(18),
  borderSide: const BorderSide(
    color: AppColors.blackColor,
    width: 1.8,
  ),
);
Widget customExpandedTextField({
  double? height,
  TextEditingController? controller,
  final FormFieldValidator<String>? validator,
  String? labelTxt,
  String? hintTxt,
  int? maxLine

}){
  return Container(
    alignment: Alignment.topLeft,
    height: height,
    child: TextFormField(
      controller: controller,
      maxLines: maxLine,
      validator: validator,
      keyboardType: TextInputType.multiline,
      cursorColor: AppColors.blackColor,
      // textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 4,vertical: SizeUtils.horizontalBlockSize * 2),
        labelText: labelTxt,
       alignLabelWithHint: true,
        hintText: hintTxt,
        border: outlineBorder,
        disabledBorder: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder:outlineBorder,
        focusedErrorBorder: outlineBorder,
        errorBorder: outlineBorder,
      ),
    ),
  );
}