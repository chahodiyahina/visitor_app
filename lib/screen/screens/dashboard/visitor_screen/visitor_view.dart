import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart' show OpenFile;
import 'package:visitor_app/screen/screens/dashboard/dashController.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/pdf_view.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_controller.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/models/visitor_model.dart';
import 'package:visitor_app/utils/appUtilas.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/navigation.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/card_container.dart' show CardContainer;
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_cachedImage.dart';
import 'package:visitor_app/widget/custom_loading_dialog.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';
import 'package:visitor_app/widget/custom_toast.dart';

import 'checkOutOptionDilog_view.dart';

class VisitorView extends StatefulWidget {
  const VisitorView({super.key});

  @override
  State<VisitorView> createState() => _VisitorViewState();
}

class _VisitorViewState extends State<VisitorView>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  final VisitorController _visitorController = Get.put(VisitorController());
  final DashController _dashController = Get.find();

  @override
  void initState() {
    super.initState();
    getVisitorApiData();
    log("get user type in visitor ${_dashController.userType.value}");
    _visitorController.tabController = TabController(
        vsync: this,
        length: /*_dashController.userType.value == AppString.security ?  4 :*/
            3);
  }

  getVisitorApiData() async {
    await _visitorController.getVisitorScreenData();
  }

  @override
  void dispose() {
    _visitorController.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(
        () => Column(children: [
          TabBar(
              controller: _visitorController.tabController,
              dividerColor: AppColors.greyF1,
              // tabAlignment: TabAlignment.start,
              indicatorColor: AppColors.black11A,
              labelColor: AppColors.black11A,
              // isScrollable: true,
              tabs: [
                Tab(
                    icon: tabTitleView(
                        title: "Pending  ",
                        num: _visitorController
                            .visitorModel.value.pendingVisitorList?.length
                            .toString())),
                Tab(
                    icon: tabTitleView(
                        num: _visitorController
                            .visitorModel.value.activeVisitorList?.length
                            .toString())),
                /* if( _dashController.userType.value == AppString.security)
                Tab(
                    icon: CustomText(
                        title: "Check Out", fontSize: SizeUtils.fSize_10())),*/
                Tab(
                    icon: tabTitleView(
                        title: "History  ",
                        num: _visitorController
                            .visitorModel.value.historyVisitorList?.length
                            .toString())),
              ]),
          SizedBox(height: SizeUtils.horizontalBlockSize * 2),
          Expanded(
            child: TabBarView(controller: _visitorController.tabController, children: [
              ///pending
              RefreshIndicator(
                onRefresh: () async {
                  await _visitorController.getVisitorScreenData();
                },
                child: ListView.builder(
                    itemCount: _visitorController
                        .visitorModel.value.pendingVisitorList?.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      VisitorList? data = _visitorController
                          .visitorModel.value.pendingVisitorList?[index];
                      return CardContainer(
                        child: Column(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imgProfileView(img: data?.imagePath),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            title: data?.name ?? "",
                                            fontSize: SizeUtils.fSize_13(),
                                            fontWeight: FontWeight.w700),
                                        const SizedBox(height: 4),
                                        CustomText(
                                            title:
                                                data?.appointmentStatus ?? "",
                                            color: AppColors.greyA6,
                                            fontSize: SizeUtils.fSize_10(),
                                            fontWeight: FontWeight.w500),
                                        const SizedBox(height: 8),
                                        Row(children: [
                                          const Icon(Icons.access_time,
                                              size: 16,
                                              color: AppColors.grey80),
                                          const SizedBox(width: 2),
                                          CustomText(
                                              title: AppUtils.convertTo12Hour(
                                                  data?.time ?? "11:59:56"),
                                              fontSize: SizeUtils.fSize_10()),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.call,
                                              size: 16, color: Colors.grey),
                                          const SizedBox(width: 2),
                                          CustomText(
                                            title: data?.mobileNumber ?? "",
                                            fontSize: SizeUtils.fSize_10(),
                                          ),
                                        ]),
                                      ]),
                                ),
                                CustomButton(
                                  onTap: () async {
                                    if (_dashController.userType.value ==
                                        AppString.security) {
                                      if (data?.imagePath == null ||
                                          (data?.imagePath ?? "").isEmpty) {
                                        _visitorController
                                            .selectedVisitorIndex.value = index;
                                        Get.toNamed(Routes.addVisitorView,
                                            arguments: AppString.visitor);
                                        CustomToast.infoToast(
                                            message:
                                                "Please upload image to chek in",
                                            context: context);
                                      } else {
                                        await _visitorController
                                            .updateAppointmentStatusCheckIn(
                                                context,
                                                id: data?.id.toString());
                                        _visitorController.tabController.index = 1;
                                      }
                                    }
                                  },
                                  title: _dashController.userType.value ==
                                          AppString.security
                                      ? 'Check In'
                                      : "Check In Panding",
                                  height: SizeUtils.verticalBlockSize * 3.6,
                                  width: _dashController.userType.value ==
                                          AppString.security
                                      ? SizeUtils.horizontalBlockSize * 24
                                      : SizeUtils.horizontalBlockSize * 26,
                                  borderColor: AppColors.grey80,
                                  buttonColor: Colors.transparent,
                                  fontSize: SizeUtils.fSize_10(),
                                ),
                              ]),
                          const SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                actionIcon(
                                    icon: Icons.print,
                                    onTap: () async {
                                      customLoadingDialog();
                                      Uint8List? imageBytes;
                                      if (data?.imagePath != null) {
                                        imageBytes =
                                            await AppUtils.imageUrlToUint8List(
                                                data?.imagePath ?? "");
                                      }
                                      generateVisitorPassPdf(
                                              hostName: data?.host ?? "-",
                                              vehicleType:
                                                  data?.vehicleType ?? "-",
                                              vehicleNo:
                                                  data?.vehicleNumber ?? "-",
                                              visitorName: data?.name ?? "-",
                                              badgeNo: data?.badgeNumber ?? "-",
                                              mobile: data?.mobileNumber ?? "-",
                                              company: data?.companyName ?? "-",
                                              checkInTime: data?.time ?? "-",
                                              department:
                                                  data?.department ?? "-",
                                              site: data?.entryPlace ?? "-",
                                              gate: data?.entryGate ?? "-",
                                              itemType: data?.itemTypes ?? "-",
                                              itemNumber:
                                                  data?.numberOfItems ?? "-",
                                              photo: imageBytes)
                                          .then((file) async {
                                        final pdfFile = File(file.path);
                                        if (pdfFile.existsSync()) {
                                          // Proceed to open the PDF
                                          await OpenFile.open(pdfFile.path);
                                        }
                                        customHideLoadingDialog();
                                      });
                                    }),
                                actionIcon(
                                    icon: Icons.person,
                                    onTap: () {
                                      _visitorController
                                          .selectedVisitorIndex.value = index;
                                      Get.toNamed(Routes.userDetailView,
                                          arguments: AppString.visitor);
                                    }),
                                actionIcon(
                                    icon: Icons.edit,
                                    onTap: () {
                                      _visitorController
                                          .selectedVisitorIndex.value = index;
                                      Get.toNamed(Routes.addVisitorView,
                                          arguments: AppString.visitor);
                                    }),
                                actionIcon(
                                    icon: Icons.delete,
                                    onTap: () {
                                      _visitorController
                                          .deleteVisitorAppointment(context,
                                              id: data?.id.toString());
                                    }),
                              ]),
                        ]),
                      );
                    }),
              ),

              ///active
              RefreshIndicator(
                onRefresh: () async {
                  await _visitorController.getVisitorScreenData();
                },
                child: ListView.builder(
                    itemCount: _visitorController
                        .visitorModel.value.activeVisitorList?.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      VisitorList? data = _visitorController
                          .visitorModel.value.activeVisitorList?[index];
                      return CardContainer(
                        child: Column(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imgProfileView(img: data?.imagePath),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            title: data?.name ?? "",
                                            fontSize: SizeUtils.fSize_13(),
                                            fontWeight: FontWeight.w700),
                                        const SizedBox(height: 4),
                                        CustomText(
                                            title:
                                                data?.appointmentStatus ?? "",
                                            color: AppColors.green,
                                            fontSize: SizeUtils.fSize_10(),
                                            fontWeight: FontWeight.w500),
                                        const SizedBox(height: 8),
                                        Row(children: [
                                          const Icon(Icons.access_time,
                                              size: 16,
                                              color: AppColors.grey80),
                                          const SizedBox(width: 2),
                                          CustomText(
                                              title: AppUtils.convertTo12Hour(
                                                  data?.time ?? "11:59:56"),
                                              fontSize: SizeUtils.fSize_10()),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.call,
                                              size: 16, color: Colors.grey),
                                          const SizedBox(width: 2),
                                          CustomText(
                                            title: data?.mobileNumber ?? "",
                                            fontSize: SizeUtils.fSize_10(),
                                          ),
                                        ]),
                                      ]),
                                ),
                                if (_dashController.userType.value ==
                                        AppString.staff ||
                                    _dashController.userType.value ==
                                        AppString.admin)
                                  data?.appointmentStatus == "Active"
                                      ? Row(children: [
                                          trueFalseView(onTap: () {
                                            _visitorController
                                                .updateAppointmentStatusApproval(
                                                    context,
                                                    id: data?.id.toString());
                                          }),
                                          SizedBox(width: 8),
                                          trueFalseView(
                                              icon: Icons.close,
                                              color: AppColors.redColor,
                                              onTap: () {
                                                _visitorController
                                                    .updateAppointmentStatusRejected(
                                                        context,
                                                        id: data?.id
                                                            .toString());
                                              }),
                                        ])
                                      : CustomButton(
                                          onTap: () {},
                                          title: 'Check Out Pending',
                                          height:
                                              SizeUtils.verticalBlockSize * 3.6,
                                          width: _dashController
                                                      .userType.value ==
                                                  AppString.security
                                              ? SizeUtils.horizontalBlockSize *
                                                  26
                                              : SizeUtils.horizontalBlockSize *
                                                  24,
                                          borderColor: AppColors.grey80,
                                          buttonColor: Colors.transparent,
                                          fontSize: SizeUtils.fSize_10()),
                                if (_dashController.userType.value ==
                                    AppString.security)
                                  CustomButton(
                                      onTap: () {
                                        if (data?.appointmentStatus !=
                                            "Active") {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) =>
                                                CheckoutOptionsDialog(
                                                    id: data?.id.toString()),
                                          );
                                        }
                                      },
                                      title: data?.appointmentStatus == "Active"
                                          ? "Approval Pending"
                                          : 'Check Out',
                                      height: SizeUtils.verticalBlockSize * 3.6,
                                      width: _dashController.userType.value ==
                                              AppString.security
                                          ? SizeUtils.horizontalBlockSize * 26
                                          : SizeUtils.horizontalBlockSize * 24,
                                      borderColor: AppColors.grey80,
                                      buttonColor: Colors.transparent,
                                      fontSize: SizeUtils.fSize_10()),
                              ]),
                          const SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                actionIcon(
                                    icon: Icons.print,
                                    onTap: () async {
                                      log("hello print");
                                      Uint8List? imageBytes;
                                      if (data?.imagePath != null) {
                                        imageBytes =
                                            await AppUtils.imageUrlToUint8List(
                                                data?.imagePath ?? "");
                                      }
                                      generateVisitorPassPdf(
                                              hostName: data?.host ?? "-",
                                              vehicleType:
                                                  data?.vehicleType ?? "-",
                                              vehicleNo:
                                                  data?.vehicleNumber ?? "-",
                                              visitorName: data?.name ?? "-",
                                              badgeNo: data?.badgeNumber ?? "-",
                                              mobile: data?.mobileNumber ?? "-",
                                              company: data?.companyName ?? "-",
                                              checkInTime: data?.time ?? "-",
                                              department:
                                                  data?.department ?? "-",
                                              site: data?.entryPlace ?? "-",
                                              gate: data?.entryGate ?? "-",
                                              itemType: data?.itemTypes ?? "-",
                                              itemNumber:
                                                  data?.numberOfItems ?? "-",
                                              photo: imageBytes)
                                          .then((file) async {
                                        final pdfFile = File(file.path);
                                        if (pdfFile.existsSync()) {
                                          // Proceed to open the PDF
                                          await OpenFile.open(pdfFile.path);
                                        }
                                      });
                                    }),
                                actionIcon(
                                    icon: Icons.person,
                                    onTap: () {
                                      _visitorController
                                          .selectedVisitorIndex.value = index;
                                      Get.toNamed(Routes.userDetailView,
                                          arguments: AppString.active);
                                    }),
                                actionIcon(
                                    icon: Icons.edit,
                                    onTap: () {
                                      _visitorController
                                          .selectedVisitorIndex.value = index;
                                      Get.toNamed(Routes.addVisitorView,
                                          arguments: AppString.active);
                                    }),
                                actionIcon(
                                    icon: Icons.delete,
                                    onTap: () {
                                      _visitorController
                                          .deleteVisitorAppointment(context,
                                              id: data?.id.toString());
                                    }),
                              ]),
                        ]),
                      );
                    }),
              ),

              ///check out
              /*if( _dashController.userType.value == AppString.security )
              Container(
                color: AppColors.bgColor2,
                padding: EdgeInsets.only(
                    right: SizeUtils.horizontalBlockSize * 3,
                    left: SizeUtils.horizontalBlockSize * 3),
                // margin: EdgeInsets.all(SizeUtils.horizontalBlockSize * 3),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(Icons.qr_code_scanner,
                              size: SizeUtils.verticalBlockSize * 3),
                          CustomText(
                              title: "  Visitor Details Scanner",
                              fontSize: SizeUtils.fSize_14(),
                              fontWeight: FontWeight.bold)
                        ]),
                        SizedBox(height: SizeUtils.verticalBlockSize * 1),
                        CustomText(
                            title:
                                "Scan visitor pass QR code or enter badge number to view details",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey80),
                        SizedBox(height: SizeUtils.verticalBlockSize * 1),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeUtils.verticalBlockSize * 1),
                          child: Row(children: [
                            Expanded(child: borderContainer(onTap: () {
                              _visitorController.selectedIndex.value = 0;
                            })),
                            SizedBox(width: SizeUtils.horizontalBlockSize * 3),
                            Expanded(
                                child: borderContainer(
                              title: " QR Scanner",
                              index: 1,
                              icon: Icons.radio_button_on,
                              onTap: () async {
                                _visitorController.selectedIndex.value = 1;
                                final result =
                                    await Get.toNamed(Routes.qrScannerPage);

                                if (result != null) {
                                  log("Scanned QR: $result");
                                }
                              },
                            )),
                          ]),
                        ),
                        CustomText(
                            color: AppColors.grey80,
                            title: "Badge Number or Visitor ID",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w600),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeUtils.horizontalBlockSize * 1,
                              bottom: SizeUtils.verticalBlockSize * 2),
                          child: CustomTextField(
                              controller: _visitorController.searchController,
                              hintText: "e.g.,V001",
                              fillColor: AppColors.whiteColor,
                              hintColor: AppColors.grey80,
                              suffixIcon: Icon(Icons.search,
                                  color: AppColors.greyA6,
                                  size: SizeUtils.horizontalBlockSize * 8)),
                        ),
                        CustomText(
                            title: "Active Visitors",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w800),
                        ListView.builder(
                            itemCount: _visitorController
                                .visitorModel.value.activeVisitorList?.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              VisitorList? data = _visitorController
                                  .visitorModel.value.activeVisitorList?[index];
                              return GestureDetector(
                                onTap: () {
                                  _visitorController
                                      .selectedVisitorIndex.value = index;
                                  Get.toNamed(Routes.userDetailView,
                                      arguments: AppString.checkOut);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color:
                                              AppColors.greyA6.withAlpha(80))),
                                  child: ListTile(
                                    title: CustomText(
                                        title: data?.name ?? "",
                                        fontSize: SizeUtils.fSize_13(),
                                        fontWeight: FontWeight.w700),
                                    subtitle: CustomText(
                                        title: data?.companyName ?? "",
                                        fontSize: SizeUtils.fSize_10()),
                                    trailing: CustomText(
                                        title: "V001",
                                        fontSize: SizeUtils.fSize_13(),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.green),
                                  ),
                                ),
                              );
                            })
                      ]),
                ),
              ),*/

              ///History
              RefreshIndicator(
                onRefresh: () async {
                  await _visitorController.getVisitorScreenData();
                },
                child: ListView.builder(
                    itemCount: _visitorController
                        .visitorModel.value.historyVisitorList?.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      VisitorList? data = _visitorController
                          .visitorModel.value.historyVisitorList?[index];
                      return CardContainer(
                        child: Column(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imgProfileView(img: data?.imagePath),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            title: data?.name ?? "",
                                            fontSize: SizeUtils.fSize_13(),
                                            fontWeight: FontWeight.w700),
                                        const SizedBox(height: 4),
                                        CustomText(
                                            title:
                                                data?.appointmentStatus ?? "",
                                            color: AppColors.greyA6,
                                            fontSize: SizeUtils.fSize_10(),
                                            fontWeight: FontWeight.w500),
                                        const SizedBox(height: 8),
                                        Row(children: [
                                          const Icon(Icons.access_time,
                                              size: 16,
                                              color: AppColors.grey80),
                                          const SizedBox(width: 2),
                                          CustomText(
                                              title: AppUtils.convertTo12Hour(
                                                  data?.time ?? "11:59:56"),
                                              fontSize: SizeUtils.fSize_10()),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.call,
                                              size: 16, color: Colors.grey),
                                          const SizedBox(width: 2),
                                          CustomText(
                                            title: data?.mobileNumber ?? "",
                                            fontSize: SizeUtils.fSize_10(),
                                          ),
                                        ]),
                                      ]),
                                ),
                                CustomButton(
                                    onTap: () {},
                                    height: SizeUtils.verticalBlockSize * 3.6,
                                    width: SizeUtils.horizontalBlockSize * 24,
                                    fontSize: SizeUtils.fSize_10(),
                                    buttonColor: const Color(0xFFF0F0F0),
                                    title: 'Completed'),
                              ]),
                          const SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                actionIcon(
                                    icon: Icons.person,
                                    onTap: () {
                                      _visitorController
                                          .selectedVisitorIndex.value = index;
                                      Get.toNamed(Routes.userDetailView,
                                          arguments: AppString.history);
                                    }),
                                actionIcon(
                                    icon: Icons.edit,
                                    onTap: () {
                                      _visitorController
                                          .selectedVisitorIndex.value = index;
                                      Get.toNamed(Routes.addVisitorView,
                                          arguments: AppString.history);
                                    }),
                                actionIcon(
                                    icon: Icons.delete,
                                    onTap: () {
                                      _visitorController
                                          .deleteVisitorAppointment(context,
                                              id: data?.id.toString());
                                    }),
                              ]),
                        ]),
                      );
                    }),
              ),
            ]),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addVisitorView, arguments: "add");
        },
        backgroundColor: AppColors.black11A,
        child: Icon(Icons.add,
            color: AppColors.whiteColor, size: SizeUtils.verticalBlockSize * 4),
      ),
    );
  }

  Widget borderContainer(
      {IconData? icon,
      String? title,
      GestureTapCallback? onTap,
      int index = 0}) {
    return Obx(
      () => GestureDetector(
        onTap: onTap ??
            () {
              _visitorController.selectedIndex.value = 0;
            },
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: SizeUtils.horizontalBlockSize * 2),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: _visitorController.selectedIndex.value == index
                      ? AppColors.black11A
                      : AppColors.greyA6)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon ?? Icons.lock_outlined),
            CustomText(
                title: title ?? " Manual Entry", fontSize: SizeUtils.fSize_12())
          ]),
        ),
      ),
    );
  }

  Widget trueFalseView(
      {Color? color, IconData? icon, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeUtils.horizontalBlockSize * 7,
        width: SizeUtils.horizontalBlockSize * 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? AppColors.green),
        child: Icon(
          icon ?? Icons.check,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget imgProfileView({String? img}) {
    return Container(
        height: SizeUtils.verticalBlockSize * 7,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: SizedBox(
          height: SizeUtils.horizontalBlockSize * 14,
          width: SizeUtils.horizontalBlockSize * 14,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CustomCachedImage(imageUrl: img ?? "")),
        ));
  }

  Widget circleContainer({required Widget child}) {
    return Container(
        height: SizeUtils.horizontalBlockSize * 5,
        width: SizeUtils.horizontalBlockSize * 5,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
            color: AppColors.black11A, shape: BoxShape.circle),
        child: child);
  }

  Widget tabTitleView({String? title, String? num}) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      CustomText(title: title ?? "Active  ", fontSize: SizeUtils.fSize_10()),
      circleContainer(
        child: CustomText(
            title: num ?? "10",
            fontSize: SizeUtils.fSize_10(),
            overflow: TextOverflow.ellipsis,
            color: AppColors.whiteColor),
      )
    ]);
  }

  Widget actionIcon({required IconData icon, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.greyEB.withAlpha(150),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: SizeUtils.verticalBlockSize * 2.2)),
    );
  }
}
