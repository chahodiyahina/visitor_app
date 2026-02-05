import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/screen/screens/dashboard/dashController.dart';
import 'package:visitor_app/screen/screens/dashboard/home_screen/home_controller.dart';
import 'package:visitor_app/screen/screens/dashboard/home_screen/home_mode.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/card_container.dart' show CardContainer;
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final HomeController _homeController = Get.put(HomeController());
  final DashController _dashController = Get.find();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getApiData();
    _tabController = TabController(vsync: this, length: 2);
  }

  getApiData() async {
    await _homeController.getHomeScreenData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(children: [
          SizedBox(height: SizeUtils.horizontalBlockSize * 2),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 3),
            height: SizeUtils.verticalBlockSize * 7.4,
            child: Row(children: [
              dashboardCard(
                  ' Active Visitors',
                  (_homeController.homeModel.value.totalTodayActive ?? 0)
                      .toString(),
                  Icons.people),
              SizedBox(width: SizeUtils.horizontalBlockSize * 2),
              dashboardCard(
                  ' Total Today',
                  (_homeController.homeModel.value.todayVisitors ?? 0)
                      .toString(),
                  Icons.today),
              SizedBox(width: SizeUtils.horizontalBlockSize * 2),
              dashboardCard(
                  ' Checked Out',
                  (_homeController.homeModel.value.totalTodayCheckOut ?? 0)
                      .toString(),
                  Icons.logout),
            ]),
          ),
          TabBar(
              controller: _tabController,
              dividerColor: AppColors.greyF1,
              indicatorColor: AppColors.black11A,
              labelColor: AppColors.black11A,
              tabs: [
                Tab(
                  icon: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.people_outline),
                    CustomText(
                        title: "  Current Visitors",
                        fontSize: SizeUtils.fSize_10())
                  ]),
                ),
                Tab(
                  icon: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.logout),
                    CustomText(
                        title: "  Recent Check-outs",
                        fontSize: SizeUtils.fSize_10())
                  ]),
                ),
              ]),
          SizedBox(height: SizeUtils.horizontalBlockSize * 2),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              RefreshIndicator(
                onRefresh: () async {
                  await _homeController.getHomeScreenData();
                },
                child: ListView.builder(
                    itemCount: _homeController
                        .homeModel.value.currentVisitorList?.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      TVisitorList? data = _homeController
                          .homeModel.value.currentVisitorList?[index];
                      return CardContainer(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.greyF1,
                                  child: CustomText(
                                      title: data?.name?[0].toUpperCase() ?? "K",
                                      fontSize: SizeUtils.fSize_14()),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          title: data?.name ?? "",
                                          fontSize: SizeUtils.fSize_13(),
                                          fontWeight: FontWeight.bold),
                                      CustomText(
                                          title: data?.email ?? "",
                                          fontSize: SizeUtils.fSize_10(),
                                          color: AppColors.grey80),
                                    ]),
                                const Spacer(),
                                CustomButton(
                                  title: _dashController.userType.value ==
                                          AppString.security
                                      ? "Check Out"
                                      : "Active",
                                  fontSize: SizeUtils.fSize_11(),
                                  buttonColor: AppColors.greyF1,
                                  height: SizeUtils.verticalBlockSize * 3.6,
                                  width: SizeUtils.horizontalBlockSize * 20,
                                  borderWidth: 1,
                                  textColor: AppColors.black11A,
                                  onTap: () async {
                                    if (_dashController.userType.value ==
                                        AppString.security) {
                                      await _homeController
                                          .updateAppointmentStatusCheckOut(
                                              context,
                                              id: data?.id.toString());
                                    }
                                  },
                                )
                              ]),
                              const Divider(),
                              RichText(
                                text: TextSpan(
                                  text: "Company:  ",
                                  children: [
                                    TextSpan(
                                      text: data?.companyName ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeUtils.fSize_10(),
                                          color: AppColors.grey80),
                                    )
                                  ],
                                  style: TextStyle(
                                      color: AppColors.black11A,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeUtils.fSize_10()),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Visiting:  ",
                                  children: [
                                    TextSpan(
                                      text: data?.createdBy ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeUtils.fSize_10(),
                                          color: AppColors.grey80),
                                    )
                                  ],
                                  style: TextStyle(
                                      color: AppColors.black11A,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeUtils.fSize_10()),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(children: [
                                const Icon(Icons.access_time, size: 16),
                                CustomText(
                                    title: ' ${data?.time ?? ""}',
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeUtils.fSize_10(),
                                    color: AppColors.grey80),
                                const Spacer(),
                                RichText(
                                  text: TextSpan(
                                    text: "Duration: ",
                                    children: [
                                      TextSpan(
                                          text: data?.duration ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.grey80)),
                                    ],
                                    style: TextStyle(
                                        color: AppColors.black11A,
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeUtils.fSize_10()),
                                  ),
                                ),
                              ])
                            ]),
                      );
                    }),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  await _homeController.getHomeScreenData();
                },
                child: ListView.builder(
                    itemCount: _homeController
                        .homeModel.value.checkoutVisitorList?.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      TVisitorList? data = _homeController
                          .homeModel.value.checkoutVisitorList?[index];
                      return CardContainer(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                CircleAvatar(
                                    backgroundColor: AppColors.greyF1,
                                    child: CustomText(
                                        title:
                                            data?.name?[0].toUpperCase() ?? "K",
                                        fontSize: SizeUtils.fSize_14())),
                                CustomText(
                                    title: '  ${data?.name}',
                                    fontSize: SizeUtils.fSize_13(),
                                    fontWeight: FontWeight.bold),
                              ]),
                              const Divider(),
                              RichText(
                                text: TextSpan(
                                  text: "Company:",
                                  children: [
                                    TextSpan(
                                        text: ' ${data?.companyName ?? ""}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: SizeUtils.fSize_10(),
                                            color: AppColors.grey80)),
                                  ],
                                  style: TextStyle(
                                      color: AppColors.black11A,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeUtils.fSize_10()),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(children: [
                                // const Icon(Icons.access_time, size: 16),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                          child:
                                              Icon(Icons.access_time, size: 16)),
                                      TextSpan(
                                          text: ' ${data?.time}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.black11A)),
                                      TextSpan(
                                          text: ' to ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.black11A)),
                                      TextSpan(
                                          text: data?.checkoutAt ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.grey80)),
                                    ],
                                    style: TextStyle(
                                        color: AppColors.grey80,
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeUtils.fSize_10()),
                                  ),
                                ),

                                const Spacer(),
                                RichText(
                                  text: TextSpan(
                                    text: "Duration:",
                                    children: [
                                      TextSpan(
                                        text: ' ${data?.duration}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: SizeUtils.fSize_10(),
                                            color: AppColors.grey80),
                                      ),
                                    ],
                                    style: TextStyle(
                                        color: AppColors.black11A,
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeUtils.fSize_10()),
                                  ),
                                ),
                              ])
                            ]),
                      );
                    }),
              ),
            ]),
          )
        ]),
      ),
    );
  }

  Widget dashboardCard(String title, String value, IconData icon,
      {double? marginL, double? marginR}) {
    return Expanded(
      child: CardContainer(
        borderRadius: 8,
        padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
        margin: EdgeInsets.zero,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Icon(icon, size: SizeUtils.verticalBlockSize * 2.2),
                CustomText(
                    title: title,
                    fontSize: SizeUtils.fSize_10(),
                    fontWeight: FontWeight.bold),
              ]),
              CustomText(
                  title: value,
                  fontSize: SizeUtils.fSize_12(),
                  fontWeight: FontWeight.bold),
            ]),
      ),
    );
  }
}
