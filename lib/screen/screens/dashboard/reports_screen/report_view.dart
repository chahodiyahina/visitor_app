import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/screen/screens/dashboard/reports_screen/report_controllar.dart';
import 'package:visitor_app/screen/screens/dashboard/reports_screen/reportsScreenData_model.dart';
import 'package:visitor_app/utils/appUtilas.dart' show AppUtils;
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/card_container.dart' show CardContainer;
import 'package:visitor_app/widget/custom_loading_dialog.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';
import 'package:visitor_app/widget/custom_toast.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final ReportControllar _reportController = Get.put(ReportControllar());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => Column(children: [
            SizedBox(height: SizeUtils.verticalBlockSize * 1),
            _filterSection(),
            if ((_reportController.reportsScreenDataModel.value.visitors ?? [])
                .isNotEmpty)
              ListView.builder(
                itemCount: _reportController
                    .reportsScreenDataModel.value.visitors?.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Visitor? data = _reportController
                      .reportsScreenDataModel.value.visitors?[index];
                  return _visitorCard(data: data);
                },
              ),
          ]),
        ),
      ),
    );
  }

  /// Filter Section
  Widget _filterSection() {
    return CardContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.apartment, color: AppColors.black11A),
          CustomText(
              title: "Visitor Reports & Analytics",
              fontSize: SizeUtils.fSize_15())
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomText(
              title:
                  "Comprehensive insights and statistics about your visitors",
              fontSize: SizeUtils.fSize_12(),
              color: AppColors.greyA6),
        ),
        _textField(controller: _reportController.userName),
        const SizedBox(height: 8),
        _textField(
            title: "Host Name:",
            controller: _reportController.hostName,
            hintTxt: "Enter host name"),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
              child: _textField(
                  title: "From:",
                  controller: _reportController.fromDate,
                  isDigit: true,
                  keyboardType: TextInputType.datetime,
                  child: GestureDetector(
                      onTap: () {
                        _reportController.pickDate(context, (date) {
                          _reportController.selectedDate.value =
                              date ?? DateTime.now();
                          _reportController.fromDate.text = AppUtils.formatDate(
                              _reportController.selectedDate.value);
                        });
                      },
                      child: const Icon(Icons.calendar_today)),
                  hintTxt: "dd/mm/yyyy")),
          const SizedBox(width: 8),
          Expanded(
              child: _textField(
                  title: "To:",
                  keyboardType: TextInputType.datetime,
                  controller: _reportController.toDate,
                  isDigit: true,
                  child: GestureDetector(
                      onTap: () {
                        _reportController.pickDate(context, (date) {
                          _reportController.selectedDate.value =
                              date ?? DateTime.now();
                          _reportController.toDate.text = AppUtils.formatDate(
                              _reportController.selectedDate.value);
                        });
                      },
                      child: const Icon(Icons.calendar_today)),
                  hintTxt: "dd/mm/yyyy")),
        ]),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ElevatedButton.icon(
            onPressed: () async {
              await _reportController.getReportsScreenData();
            },
            icon: const Icon(Icons.search, color: AppColors.black11A),
            label: const CustomText(title: "Search"),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                side: const BorderSide(color: AppColors.borderColor, width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0),
          ),
          if ((_reportController.reportsScreenDataModel.value.visitors ?? [])
              .isNotEmpty)
            ElevatedButton.icon(
              onPressed: () async {
                _reportController.requestPermission();
                final csvText = _reportController.visitorsToCsv(
                    _reportController.reportsScreenDataModel.value.visitors ??
                        []);
                final file = await _reportController.saveCsvToDownloads(
                    csvText, context);
                print('CSV saved at: ${file.path}');
              },
              icon: const Icon(Icons.search, color: AppColors.black11A),
              label: const CustomText(title: "Export CSV"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  side:
                      const BorderSide(color: AppColors.borderColor, width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0),
            ),
        ])
      ]),
    );
  }

  /// Visitor Card
  Widget _visitorCard({Visitor? data}) {
    return CardContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _row("Visitor", data?.name ?? ''),
        _row("Host", data?.host ?? ''),
        _row("Company", data?.companyName ?? ''),
        _row("Mobile", data?.mobileNumber ?? ''),
        _row("Email", data?.email ?? ''),
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomText(
              title: "📅 ${AppUtils.formatDate(data?.date ?? DateTime.now())}",
              fontWeight: FontWeight.normal,
              fontSize: SizeUtils.fSize_11()),
          CustomText(
              title: "⏰ ${data?.time}"  /*${AppUtils.formatDate(data?.time ?? DateTime.now())}"*/,
              fontWeight: FontWeight.normal,
              fontSize: SizeUtils.fSize_11())
        ])
      ]),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        SizedBox(
            width: SizeUtils.horizontalBlockSize * 26,
            child: CustomText(
                title: "$title:",
                fontSize: SizeUtils.fSize_11(),
                fontWeight: FontWeight.w600)),
        Expanded(
            child: CustomText(
                title: value,
                fontSize: SizeUtils.fSize_11(),
                fontWeight: FontWeight.normal)),
      ]),
    );
  }

  Widget _textField(
      {required TextEditingController controller,
      String? title,
      Widget? child,
      bool? isDigit,
      TextInputType keyboardType = TextInputType.text,
      String? hintTxt}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(title: title ?? "User name:"),
      CustomTextField(
          controller: controller,
          keyboardType: keyboardType,
          fillColor: AppColors.fillColor,
          hintText: hintTxt ?? "Enter user name",
          suffixIcon: child,
          isNumber: isDigit ?? false),
    ]);
  }
}
