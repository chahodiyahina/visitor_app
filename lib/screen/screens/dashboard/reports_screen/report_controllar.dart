import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visitor_app/constant/endpoint_constant.dart';
import 'package:visitor_app/screen/screens/dashboard/reports_screen/reportsScreenData_model.dart';
import 'package:visitor_app/services/http_services.dart';
import 'package:visitor_app/utils/appUtilas.dart';
import 'package:visitor_app/widget/custom_toast.dart';

class ReportControllar extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController hostName = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<ReportsScreenDataModel> reportsScreenDataModel =
      ReportsScreenDataModel().obs;

  ///date picker
  Future<void> pickDate(
    BuildContext context,
    Function(DateTime?) onDateSelected,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Colors.blue, // selected date color
                  onPrimary: Colors.white,
                  onSurface: Colors.black),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: Colors.blue),
              ),
            ),
            child: child!);
      },
    );
    onDateSelected(picked);
  }

  Future<void> getReportsScreenData() async {
    try {
      Map<String, dynamic> data = {
        "fromDate": fromDate.text.isNotEmpty
            ? AppUtils.formatDateFormat(fromDate.text.trim())
            : "",
        "hostName": hostName.text.isNotEmpty ? hostName.text.trim() : "",
        "toDate": toDate.text.isNotEmpty
            ? AppUtils.formatDateFormat(toDate.text.trim())
            : "",
        "userName": userName.text.isNotEmpty ? userName.text.trim() : ""
      };
      log("get visitor payload:-$data");
      var response = await HttpServices.postHttpMethod(
          url: ApiEndPoint.getRepostScreenVisitorData, data: data);
      log("getReportsScreenData response data ::: ${response['body']} ");
      if (response['error_description'] == null) {
        log("getReportsScreenData SUCCESS ::: ${response['body']}");
        reportsScreenDataModel.value =
            reportsScreenDataModelFromJson(response['body']);
        log("getReportsScreenData response data ::: ${reportsScreenDataModel.value.toJson()}");
      } else {
        log("getReportsScreenData FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("getReportsScreenData erro $e === $st ====");
    }
  }

  Future<void> requestPermission() async {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }

    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
  }


  String visitorsToCsv(List<Visitor> visitors) {
    List<List<String>> rows = [];

    // HEADER ROW
    rows.add([
      'ID',
      'Name',
      'Email',
      'Mobile',
      'Company',
      'Vehicle No',
      'Vehicle Type',
      'Items',
      'Item Types',
      'Host',
      'Department',
      'Date',
      'Time',
      'Status',
    ]);

    // DATA ROWS
    for (final v in visitors) {
      rows.add([
        v.id?.toString() ?? '',
        v.name ?? '',
        v.email ?? '',
        v.mobileNumber ?? '',
        v.companyName ?? '',
        v.vehicleNumber ?? '',
        v.vehicleType ?? '',
        v.numberOfItems ?? '',
        v.itemTypes ?? '',
        v.host ?? '',
        v.department ?? '',
        v.date != null
            ? "${v.date!.year}-${v.date!.month.toString().padLeft(2, '0')}-${v.date!.day.toString().padLeft(2, '0')}"
            : '',
        v.time ?? "",
        v.appointmentStatus ?? '',
      ]);
    }
    return const ListToCsvConverter().convert(rows);
  }

  Future<Directory> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();

      final downloadDir = Directory(
        '${directory!.path.split('Android')[0]}Download',
      );

      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }
      return downloadDir;
    }
    // iOS fallback
    return await getApplicationDocumentsDirectory();
  }


  Future<File> saveCsvToDownloads(String csvText,context) async {
    final dir = await getDownloadDirectory();
    final file = File('${dir.path}/visitors_export_${DateTime.now().millisecondsSinceEpoch}.csv');

    await file.writeAsString(csvText);
    CustomToast.infoToast(message: "File successfully stored at ${file.path}",context: context);
    return file;
  }
}
