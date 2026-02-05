import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/models/masterUser_model.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/master_controller.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/models/vehicle_model.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/vehicle_dilogue_view.dart';
import 'package:visitor_app/utils/navigation.dart' show Routes;
import 'package:visitor_app/utils/size_utils.dart' show SizeUtils;
import 'package:visitor_app/widget/card_container.dart' show CardContainer;
import 'package:visitor_app/widget/custom_switch_button.dart' show CustomSwitch;
import 'package:visitor_app/widget/custom_text.dart' show CustomText;

class MasterView extends StatefulWidget {
  const MasterView({super.key});

  @override
  State<MasterView> createState() => _MasterViewState();
}

class _MasterViewState extends State<MasterView>
    with SingleTickerProviderStateMixin {
  final MasterController _masterController = Get.put(MasterController());
  late TabController _tabController;

  @override
  void initState() {
    getApiData();
    _tabController = TabController(vsync: this, length: 4);
    _masterController.selectedTabIndex.value = 0;
    _tabController.addListener(() {
      // Fires on tap + swipe
      if (!_tabController.indexIsChanging) {
        _masterController.selectedTabIndex.value = _tabController.index;
      }
    });
    super.initState();
  }

  getApiData() async {
    await _masterController.getMasterScreenData();
    await _masterController.getVehicleData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  left: SizeUtils.horizontalBlockSize * 3,
                  top: SizeUtils.verticalBlockSize * 2,
                  bottom: SizeUtils.verticalBlockSize * 1),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Icon(Icons.people_alt_outlined,
                    size: SizeUtils.verticalBlockSize * 3),
                CustomText(
                    title: "  Master Data Management",
                    fontSize: SizeUtils.fSize_15(),
                    fontWeight: FontWeight.bold),
              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 3),
              child: CustomText(
                  title: "Manage users and other master data",
                  color: AppColors.grey80,
                  fontSize: SizeUtils.fSize_11()),
            ),
            TabBar(
                controller: _tabController,
                dividerColor: AppColors.greyF1,
                indicatorColor: AppColors.black11A,
                labelColor: AppColors.black11A,
                tabs: [
                  Tab(icon: tabText()),
                  Tab(icon: tabText(title: "Staff")),
                  Tab(icon: tabText(title: "Security")),
                  Tab(icon: tabText(title: "Vehicle")),
                ]),
            SizedBox(height: SizeUtils.horizontalBlockSize * 1),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                ///Admin
                RefreshIndicator(
                  onRefresh: () async {
                    await _masterController.getMasterScreenData();
                  },
                  child: ListView.builder(
                    itemCount:
                        _masterController.masterUserModel.value.data?.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Datum? data =
                          _masterController.masterUserModel.value.data?[index];
                      return data?.isSuperuser == false
                          ? const SizedBox.shrink()
                          : _employeeCard(data, index);
                    },
                  ),
                ),

                ///Staff
                RefreshIndicator(
                  onRefresh: () async {
                    await _masterController.getMasterScreenData();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        _masterController.masterUserModel.value.data?.length,
                    itemBuilder: (context, index) {
                      Datum? data =
                          _masterController.masterUserModel.value.data?[index];
                      return (data?.isSuperuser == false && data?.isStaff == true)
                          ? _employeeCard(data, index)
                          : const SizedBox.shrink();
                    },
                  ),
                ),

                ///security
                RefreshIndicator(
                  onRefresh: () async {
                    await _masterController.getMasterScreenData();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        _masterController.masterUserModel.value.data?.length,
                    itemBuilder: (context, index) {
                      Datum? data =
                          _masterController.masterUserModel.value.data?[index];
                      return data?.isSecurity == true
                          ? _employeeCard(data, index)
                          : const SizedBox.shrink();
                    },
                  ),
                ),

                ///vehicle
                RefreshIndicator(
                  onRefresh: () async {
                    await _masterController.getMasterScreenData();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        _masterController.vehicleModel.value.vehicleData?.length,
                    itemBuilder: (context, index) {
                      VehicleDatum? data = _masterController
                          .vehicleModel.value.vehicleData?[index];
                      return CardContainer(
                        borderRadius: 8,
                        child: Column(children: [
                          Row(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      title: "ID:",
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeUtils.fSize_11()),
                                  CustomText(
                                      title: "Vehicle type:",
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeUtils.fSize_11()),
                                ]),
                            SizedBox(width: SizeUtils.horizontalBlockSize * 6),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      title: data?.id.toString() ?? "",
                                      fontSize: SizeUtils.fSize_11()),
                                  CustomText(
                                      title: data?.vehicleType ?? "",
                                      fontSize: SizeUtils.fSize_11()),
                                ]),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  _masterController.vehicleController.text =
                                      data?.vehicleType ?? "";
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => AddVehicleDialog(
                                            isEditVehicle: true,
                                            vehicleId: data?.id.toString(),
                                          ));
                                },
                                child: const Icon(Icons.edit_outlined)),
                            const SizedBox(width: 5),
                            GestureDetector(
                                onTap: () {
                                  _masterController.deleteVehicle(
                                      id: (data?.id).toString());
                                },
                                child: const Icon(Icons.delete_outline)),
                          ]),
                        ]),
                      );
                    },
                  ),
                ),
              ]),
            )
          ]),
        ),
        floatingActionButton: Obx(
          () => FloatingActionButton.extended(
            onPressed: () {
              if (_masterController.selectedTabIndex.value != 3) {
                Get.toNamed(Routes.addUserView, arguments: "add");
              } else if (_masterController.selectedTabIndex.value == 3) {
                _masterController.vehicleController.clear();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AddVehicleDialog());
              }
            },
            backgroundColor: AppColors.black11A,
            label: CustomText(
                title: _masterController.selectedTabIndex.value == 3
                    ? "Add Vehicle"
                    : "Add User",
                color: AppColors.whiteColor),
            icon: Icon(Icons.add,
                color: AppColors.whiteColor,
                size: SizeUtils.verticalBlockSize * 3),
          ),
        ));
  }

  Widget tabText({String? title}) {
    return CustomText(title: title ?? "Admin", fontSize: SizeUtils.fSize_13());
  }

  Widget _employeeCard(Datum? data, int index) {
    return CardContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _row("Name", data?.name ?? ""),
        _row("Email", data?.email ?? ""),
        _row("Phone", data?.mobileNumber ?? ""),
        _row("Department", data?.department ?? ""),
        const Divider(),

        /// Status + Action
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            CustomSwitch(
              value: data?.isActive ?? false,
              onChanged: (val) async {
                data?.isActive = val;
                _masterController.masterUserModel.refresh();
                await _masterController.updateUserActive(
                    id: data?.id.toString(), isActive: val);
                _masterController.masterUserModel.refresh();
              },
            ),
            Container(
              width: SizeUtils.horizontalBlockSize * 22,
              height: SizeUtils.horizontalBlockSize * 6,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  color: (data?.isActive ?? false)
                      ? AppColors.black11A
                      : AppColors.greyEB,
                  borderRadius: BorderRadius.circular(15)),
              child: CustomText(
                  title: (data?.isActive ?? false) ? "Active" : "Inactive",
                  fontSize: SizeUtils.fSize_11(),
                  color: (data?.isActive ?? false)
                      ? AppColors.whiteColor
                      : AppColors.black11A),
            ),
          ]),
          IconButton(
              onPressed: () {
                _masterController.selectedUserIndex.value = index;
                Get.toNamed(Routes.addUserView, arguments: "data");
              },
              icon: const Icon(Icons.edit))
        ])
      ]),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: SizeUtils.horizontalBlockSize * 24,
          child: CustomText(
              title: "$title:",
              fontWeight: FontWeight.w600,
              fontSize: SizeUtils.fSize_11()),
        ),
        Expanded(
          child: CustomText(title: value, fontWeight: FontWeight.w400),
        ),
      ]),
    );
  }
}
