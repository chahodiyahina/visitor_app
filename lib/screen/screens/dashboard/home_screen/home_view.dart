import 'package:flutter/material.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 2),
        child: Column(children: [
          SizedBox(
            height: SizeUtils.verticalBlockSize * 9,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              dashboardCard(' Active Visitors', '4', Icons.people),
              dashboardCard(' Total Today', '9', Icons.today),
              dashboardCard(' Checked Out', '5', Icons.logout),
            ]),
          ),
          TabBar(
            controller: _tabController,
            dividerColor: AppColors.purple,
            tabs: [
              Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.people_outline),
                      CustomText(
                        title: "  Current Visitors",
                        fontSize: SizeUtils.fSize_10(),
                      )
                    ],
                  )),
              Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.logout),
                      CustomText(
                        title: "  Recent Check-outs",
                        fontSize: SizeUtils.fSize_10(),
                      )
                    ],
                  )),
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tabController,
                children: [
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (index, context) {
                        return Card(
                          color: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    CircleAvatar(
                                        backgroundColor: AppColors.purple,
                                        // backgroundColor: AppColors.greyA6.withOpacity(0.2),
                                        child: CustomText(
                                            title: 'R',
                                            fontSize: SizeUtils.fSize_14())),
                                    const SizedBox(width: 8),
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              title: 'Rashmin',
                                              fontSize: SizeUtils.fSize_13(),
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black11A),
                                          CustomText(
                                              title: 'contact@shkart.in',
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.grey80),
                                        ]),
                                    const Spacer(),
                                    CustomButton(
                                      title: "Active",
                                      fontSize: SizeUtils.fSize_11(),
                                      buttonColor:
                                      AppColors.greyA6.withOpacity(0.1),
                                      height: SizeUtils.verticalBlockSize * 3.6,
                                      borderWidth: 1,
                                      textColor: AppColors.black11A,
                                      onTap: () {},
                                      width: SizeUtils.horizontalBlockSize * 16,
                                      // buttonColor: Colors.transparent
                                    )
                                  ]),
                                  const Divider(),
                                  RichText(
                                      text: TextSpan(
                                          text: "Company:",
                                          children: [
                                            TextSpan(
                                                text: ' SHREE HARI KRISHNA ART',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                    SizeUtils.fSize_10(),
                                                    color: AppColors.grey80)),
                                          ],
                                          style: TextStyle(
                                              color: AppColors.black11A,
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10()))),
                                  RichText(
                                      text: TextSpan(
                                          text: "Visiting:",
                                          children: [
                                            TextSpan(
                                                text: ' Akshay - Director',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                    SizeUtils.fSize_10(),
                                                    color: AppColors.grey80)),
                                          ],
                                          style: TextStyle(
                                              color: AppColors.black11A,
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10()))),
                                  const SizedBox(height: 6),
                                  Row(children: [
                                    const Icon(Icons.access_time, size: 16),
                                    CustomText(
                                        title: ' 16:53:11',
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeUtils.fSize_10(),
                                        color: AppColors.grey80),
                                    const Spacer(),
                                    RichText(
                                        text: TextSpan(
                                            text: "Duration:",
                                            children: [
                                              TextSpan(
                                                  text: ' 40m',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize:
                                                      SizeUtils.fSize_10(),
                                                      color: AppColors.grey80)),
                                            ],
                                            style: TextStyle(
                                                color: AppColors.black11A,
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                SizeUtils.fSize_10()))),
                                  ])
                                ]),
                          ),
                        );
                      }),
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (index, context) {
                        return Card(
                          color: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    CircleAvatar(
                                        backgroundColor: AppColors.purple,
                                        // backgroundColor: AppColors.greyA6.withOpacity(0.2),
                                        child: CustomText(
                                            title: 'R',
                                            fontSize: SizeUtils.fSize_14())),
                                    CustomText(
                                        title: '  Rashmin',
                                        fontSize: SizeUtils.fSize_13(),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black11A),
                                  ]),
                                  const Divider(),
                                  RichText(
                                      text: TextSpan(
                                          text: "Company:",
                                          children: [
                                            TextSpan(
                                                text: ' SHREE HARI KRISHNA ART',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                    SizeUtils.fSize_10(),
                                                    color: AppColors.grey80)),
                                          ],
                                          style: TextStyle(
                                              color: AppColors.black11A,
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10()))),
                                  const SizedBox(height: 6),
                                  Row(children: [
                                    // const Icon(Icons.access_time, size: 16),
                                    RichText(
                                        text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                  child: Icon(Icons.access_time,
                                                      size: 16)),
                                              TextSpan(
                                                  text: ' 16:53:11',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize:
                                                      SizeUtils.fSize_10(),
                                                      color: AppColors.black11A)),
                                              TextSpan(
                                                  text: ' to ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize:
                                                      SizeUtils.fSize_10(),
                                                      color: AppColors.black11A)),
                                              TextSpan(
                                                  text: '16:53:11',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize:
                                                      SizeUtils.fSize_10(),
                                                      color: AppColors.grey80)),
                                            ],
                                            style: TextStyle(
                                                color: AppColors.grey80,
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                SizeUtils.fSize_10()))),

                                    const Spacer(),
                                    RichText(
                                        text: TextSpan(
                                            text: "Duration:",
                                            children: [
                                              TextSpan(
                                                  text: ' 40m',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize:
                                                      SizeUtils.fSize_10(),
                                                      color: AppColors.grey80)),
                                            ],
                                            style: TextStyle(
                                                color: AppColors.black11A,
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                SizeUtils.fSize_10()))),
                                  ])
                                ]),
                          ),
                        );
                      }),
                ]),
          )
        ]),
      ),
    );
  }
  Widget dashboardCard(String title, String value, IconData icon) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      // decoration: BoxDecoration(
      //   color: AppColors.whiteColor,
      //   borderRadius: BorderRadius.circular(16),
      //   boxShadow:  [BoxShadow(color: AppColors.black11A.withOpacity(0.2), blurRadius: 4)],
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Icon(
                  icon,
                  size: SizeUtils.verticalBlockSize * 2.2,
                ),
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
