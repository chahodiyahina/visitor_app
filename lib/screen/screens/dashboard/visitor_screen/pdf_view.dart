import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:visitor_app/constant/app_images.dart';
import 'package:visitor_app/utils/appUtilas.dart';

/* /// for single page
Future<File> generateVisitorPassPdf({
  required String badgeNo,
  required String visitorName,
  required String mobile,
  required String hostName,
  required String department,
  required String company,
  required String site,
  required String gate,
  required String vehicleNo,
  required String vehicleType,
  required String checkInTime,
  Uint8List? photo,
  Uint8List? qrImage,
}) async {
  log("get name in pfd view:- $visitorName");
  final pdf = pw.Document();

  final fontData =
      await rootBundle.load('assets/fonts/open_sans/OpenSans-Regular.ttf');
  final ttf = pw.Font.ttf(fontData);

  pdf.addPage(
      pw.Page(
      pageFormat: PdfPageFormat.a6,
      // maxPages: 4,
      theme: pw.ThemeData.withFont(
      base: ttf, // Set the default font for the entire document
      italic: pw.Font.ttf(await rootBundle.load("assets/fonts/open_sans/OpenSans-Italic.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("assets/fonts/open_sans/OpenSans-Bold.ttf")),
      boldItalic: pw.Font.ttf(await rootBundle.load("assets/fonts/open_sans/OpenSans-BoldItalic.ttf")),
    ),
      build: (context) {
        return pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.green, width: 2),
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                /// HEADER
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(site,
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green)),
                        pw.Text("Visitor Pass",
                            style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green)),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.green,
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      child: pw.Column(
                        children: [
                          pw.Text("Badge No.",
                              style: const pw.TextStyle(
                                  fontSize: 12, color: PdfColors.white)),
                          pw.Text(badgeNo,
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
                pw.Divider(),

                /// BODY
                pw.SizedBox(height: 10),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    /// LEFT COLUMN
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            height: 70,
                            width: 70,
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.green),
                              borderRadius: pw.BorderRadius.circular(8),
                            ),
                            child: photo != null
                                ? pw.Image(pw.MemoryImage(photo))
                                : pw.Text("No Photo",
                                    style: const pw.TextStyle(fontSize: 10,color: PdfColors.black)),
                          ),
                          pw.SizedBox(height: 12),
                          _labelValue("Visitor Name", visitorName),
                          _labelValue("Site", site),
                          _labelValue("Gate Number", gate),
                          _labelValue("Check-in Time", checkInTime),
                          pw.SizedBox(height: 12),
                          if (qrImage != null)
                            pw.Container(
                              height: 70,
                              width: 70,
                              child: pw.Image(pw.MemoryImage(qrImage)),
                            ),
                        ]),

                    pw.SizedBox(width: 20),

                    /// RIGHT COLUMN
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _labelValue("Mobile Number", mobile),
                          _labelValue("Host Name", "$hostName\n($department)"),
                          _labelValue("Company", company),
                          _labelValue("Vehicle Number", vehicleNo),
                          _labelValue("Vehicle Type", vehicleType),
                          _labelValue("Item Type", "-"),
                          _labelValue("Inward Items", "-"),
                          pw.SizedBox(height: 6),
                          pw.Text("Outward Items", style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey)),
                          pw.SizedBox(height: 6),
                          pw.Container(
                            height: 1,
                            color: PdfColors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                /// SIGNATURES
                // pw.PageBreak(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _signature("Security In Signature"),
                    pw.SizedBox(height: 8),
                    _signature("Security Out Signature"),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _signature("Host Signature"),
                    pw.SizedBox(height: 8),
                    _signature("Visitor Signature"),
                  ],
                ),
              ],
            ),
          );
      },
    ),
  );

  final dir = await getTemporaryDirectory();
  final file = File("${dir.path}/visitor_pass.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}

pw.Widget _labelValue(String label, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 6),
    child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label,
              style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey)),
          pw.Text(value,
              style:
                  pw.TextStyle(fontSize: 7,color: PdfColors.black, fontWeight: pw.FontWeight.bold)),
        ]),
  );
}

pw.Widget _signature(String title) {
  return pw.Column(
    children: [
      pw.Container(width: 80, height: 1, color: PdfColors.grey),
      pw.SizedBox(height: 4),
      pw.Text(title, style: const pw.TextStyle(fontSize: 7,color: PdfColors.black)),
    ],
  );
}
*/

Future<File> generateVisitorPassPdf({
  required String badgeNo,
  required String visitorName,
  required String mobile,
  required String hostName,
  required String department,
  required String company,
  required String site,
  required String gate,
  required String vehicleNo,
  required String vehicleType,
  required String checkInTime,
  required String itemType,
  required String itemNumber,
  Uint8List? photo,
}) async {
  log("Generating PDF for: $visitorName");

  Uint8List? imageBytes;
  if (photo == null) {
    imageBytes = await AppUtils.loadImageFromAssets(AppImage.personIcon);
  }

  final pdf = pw.Document();

  final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/open_sans/OpenSans-Regular.ttf'));

  final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/open_sans/OpenSans-Bold.ttf'));

  final italicFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/open_sans/OpenSans-Italic.ttf'));

  final boldItalicFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/open_sans/OpenSans-BoldItalic.ttf'));

  pdf.addPage(
    pw.MultiPage(
        pageFormat: PdfPageFormat.a6,
        margin: const pw.EdgeInsets.all(10),
        theme: pw.ThemeData.withFont(
          base: regularFont,
          bold: boldFont,
          italic: italicFont,
          boldItalic: boldItalicFont,
        ),
        build: (context) => [
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.green, width: 2),
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      /// HEADER
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(site,
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.green)),
                                pw.Text("Visitor Pass",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.green)),
                              ],
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.green,
                                borderRadius: pw.BorderRadius.circular(6),
                              ),
                              child: pw.Column(children: [
                                pw.Text("Badge No.",
                                    style: const pw.TextStyle(
                                        fontSize: 10, color: PdfColors.white)),
                                pw.Text(badgeNo,
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        color: PdfColors.white,
                                        fontWeight: pw.FontWeight.bold)),
                              ]),
                            ),
                          ]),

                      pw.Divider(color: PdfColors.grey),

                      /// BODY
                pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal:10),
                   child:    pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,

                          children: [
                            /// LEFT
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    height: 65,
                                    width: 65,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(color: PdfColors.green,width: 2),
                                      borderRadius: pw.BorderRadius.circular(8),
                                      // color: PdfColors.white,
                                      boxShadow: [
                                        pw.BoxShadow(
                                          color: PdfColors.grey50,
                                          blurRadius: 2,
                                          spreadRadius: 4,
                                          offset: PdfPoint.zero, // X, Y
                                        ),
                                      ],
                                    ),
                                    child: pw.ClipRRect(
                                      horizontalRadius: 10,
                                      verticalRadius: 10,
                                      child: pw.Image(
                                        pw.MemoryImage(photo ?? imageBytes!),
                                        fit: pw.BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(height: 10),
                                  _labelValue("Visitor Name", visitorName),
                                  _labelValue("Site", site),
                                  _labelValue("Gate Number", gate),
                                  _labelValue("Check-in Time", checkInTime),
                                  pw.SizedBox(height: 10),
                                ]),

                            pw.SizedBox(width: 35),

                            /// RIGHT
                            pw.Expanded(
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    _labelValue("Mobile Number", mobile),
                                    _labelValue("Host Name",
                                        "$hostName\n($department)"),
                                    _labelValue("Company", company),
                                    _labelValue("Vehicle Number", vehicleNo),
                                    _labelValue("Vehicle Type", vehicleType),
                                    _labelValue("Item Type", itemType),
                                    _labelValue("Inward Items", itemNumber),
                                    pw.SizedBox(height: 6),
                                    pw.Text("Outward Items",
                                        style: const pw.TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.grey)),

                                    pw.Container(
                                      margin: pw.EdgeInsets.only(top: 10),
                                        height: 1, color: PdfColors.grey),
                                  ]),
                            ),
                          ]),),
                      pw.SizedBox(height: 20),

                      /// SIGNATURES
                pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal:10),
                     child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            _signature("Security In"),
                            _signature("Security Out"),
                          ]),),
                      pw.SizedBox(height: 20),
                      pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal:10),
                        child:  pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            _signature("Host"),
                            _signature("Visitor"),
                          ]),),
                    ]),
              ),
            ]),
  );

  final dir = await getTemporaryDirectory();
  final file = File("${dir.path}/visitor_pass.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}

pw.Widget _labelValue(String label, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 6),
    child:
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Text(label,
          style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey)),
      pw.Text(value,
          style: pw.TextStyle(
              fontSize: 7,
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold)),
    ]),
  );
}

pw.Widget _signature(String title) {
  return pw.Column(children: [
    pw.Container(width: 70, height: 1, color: PdfColors.grey),
    pw.SizedBox(height: 4),
    pw.Text(title,
        style: const pw.TextStyle(fontSize: 7, color: PdfColors.black)),
  ]);
}
