import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:visitor_app/constant/app_color.dart' show AppColors;
import 'package:visitor_app/widget/custom_text.dart' show CustomText;

class CustomDropdownField extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // 🔐 SAFETY CHECK (MOST IMPORTANT LINE)
    final String? safeValue =
    items.contains(value) ? value : null;
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: safeValue,
      hint: CustomText(title: hint),

      /// ITEMS
      items: items.toSet()
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: CustomText(title: item),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,

      /// INPUT DECORATION
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.fillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.black11A),
        ),
      ),

      /// BUTTON STYLE
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 6),
      ),

      /// ICON
      iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
          iconSize: 24),

      /// DROPDOWN MENU
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        offset: const Offset(0, 8),
      ),

      /// MENU ITEM
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
