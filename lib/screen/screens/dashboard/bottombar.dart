import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/screen/screens/dashboard/dashController.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/size_utils.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final DashController _dashController = Get.find();

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.people_outline, 'label': 'Visitor'},
    {'icon': Icons.bar_chart_outlined, 'label': 'Reports'},
    {'icon': Icons.admin_panel_settings_outlined, 'label': 'Master'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      height: SizeUtils.verticalBlockSize * 8.6,
      decoration:  const BoxDecoration(
        color: AppColors.black11A,
        // boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6,spreadRadius: 4)],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          return Obx(
            ()=> GestureDetector(
              onTap: () {
                _dashController.dashIndex.value = index;
                _dashController.dashIndex.refresh();
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 2),
                    padding:  EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 4, vertical:SizeUtils.verticalBlockSize *0.6),
                    decoration: BoxDecoration(
                      color: _dashController.dashIndex.value == index
                          ? AppColors.greyA6.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(_items[index]['icon'],size: SizeUtils.verticalBlockSize * 2.8, color: AppColors.whiteColor),
                  ),
                  Text(
                    _items[index]['label'],
                    style:   TextStyle(
                        fontSize: SizeUtils.fSize_9(),
                        color: AppColors.whiteColor
                    ),
                  ),
                ]
              ),
            ),
          );
        }),
      ),
    );
  }
}
