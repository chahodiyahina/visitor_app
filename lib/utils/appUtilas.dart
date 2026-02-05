import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class AppUtils {

  static String convertTo12Hour(String time24) {
    final inputFormat = DateFormat("HH:mm:ss");
    final outputFormat = DateFormat("h:mm a");

    final dateTime = inputFormat.parse(time24);
    return outputFormat.format(dateTime);
  }

  static  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }


  static String formatDateFormat(String date) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');

    final parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }


 static Future<String?> fileToBase64(String? path) async {
    try {
      if (path == null || path.isEmpty) return null;

      final file = File(path);
      if (!await file.exists()) return null;

      final bytes = await file.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint("Base64 conversion error: $e");
      return null;
    }
  }

  static Future<String?> imageUrlToBase64(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return base64Encode(response.bodyBytes);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Image URL to Base64 error: $e");
      return null;
    }
  }

  static Future<Uint8List> imageUrlToUint8List(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}