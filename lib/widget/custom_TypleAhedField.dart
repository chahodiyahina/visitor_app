import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:visitor_app/constant/app_color.dart';

class CustomTypeAheadField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Future<List<String>> Function(String query) suggestionsCallback;
  final void Function(String value) onSelected;
  final String? hintText;
  final int minChar;

  const CustomTypeAheadField({
    super.key,
    required this.controller,
    required this.suggestionsCallback,
    required this.onSelected,
    this.focusNode,
    this.hintText,
    this.minChar = 2,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      controller: controller,
      builder: (context, textController, focusNode) {
        return TextField(
          controller: textController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.hintTextColor),
            filled: true,
            fillColor: AppColors.fillColor,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(),
            errorBorder: _border(),
            focusedErrorBorder: _border(),
          ),
        );
      },

      /// API CALL
      suggestionsCallback: (query) async {
        if (query.length < minChar) return [];
        return await suggestionsCallback(query);
      },

      /// DROPDOWN ITEM UI
      itemBuilder: (context, suggestion) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            suggestion,
            style: const TextStyle(fontSize: 16),
          ),
        );
      },

      /// ON SELECT
      onSelected: onSelected,

      hideOnEmpty: true,
      hideOnError: true,
      hideOnLoading: false,
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.borderColor,
        width: 1.8,
      ),
    );
  }
}
