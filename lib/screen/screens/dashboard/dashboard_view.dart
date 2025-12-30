import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:visitor_app/screen/screens/dashboard/bottombar.dart';
import 'package:visitor_app/screen/screens/dashboard/dashController.dart';
import 'package:visitor_app/screen/screens/dashboard/home_screen/home_view.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/master_view.dart';
import 'package:visitor_app/screen/screens/dashboard/reports_screen/report_view.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_view.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_text.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashController _dashController = Get.put(DashController());

  final List<Widget> _screens = [
    const HomeView(),
    const VisitorView(),
    const ReportView(),
    const MasterView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: AppColors.whiteColor,
          shadowColor: AppColors.black11A,
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 2),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  // dividerColor: AppColors.grey80
                ),
                child: PopupMenuButton(
                    color: AppColors.whiteColor,
                    offset: const Offset(0, 40),
                    child: const CircleAvatar(
                      child: CustomText(
                        title: "K",
                        color: AppColors.black11A,
                      ),
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            padding: const EdgeInsets.only(left: 8),
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: CustomText(
                                  title: "K",
                                  color: AppColors.black11A,
                                ),
                              ),
                              title: CustomText(
                                title: "Rashmin Patel",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w800,
                                color: AppColors.black11A,
                              ),
                            ),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => _buildPopupDialog(context),
                              );
                            },
                            child: ListTile(
                              leading: const Icon(Icons.logout),
                              title: CustomText(
                                title: 'Logout',
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w800,
                                color: AppColors.black11A,
                              ),
                            ),
                          ),
                        ]),
              ),
            )
          ],
          title: CustomText(
              title: AppString.appName,
              fontSize: SizeUtils.fSize_20(),
              fontWeight: FontWeight.bold),
        ),
        body: Obx(() => _screens[_dashController.dashIndex.value]),
        bottomNavigationBar: const BottomNavBar());
  }
  Widget _buildPopupDialog(BuildContext context) {
    return  AlertDialog(
      content:  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(title:"Are you sure you want to log out this app?",textAlign: TextAlign.center,fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w600,color: AppColors.black11A,),
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: CustomButton(title: "Yes",fontSize:SizeUtils.fSize_15(), textColor:AppColors.whiteColor, onTap: ()=>
                Get.back()),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButton(title: "Cancel",fontSize:SizeUtils.fSize_15(),textColor: AppColors.whiteColor,onTap: ()=>
                  Get.back()),
            ),
          ],
        )
      ],
    );
  }
}
