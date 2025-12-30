import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_controller.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/constant/app_images.dart';
import 'package:visitor_app/utils/navigation.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';

class VisitorView extends StatefulWidget {
  const VisitorView({super.key});

  @override
  State<VisitorView> createState() => _VisitorViewState();
}

class _VisitorViewState extends State<VisitorView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final VisitorController _visitorController = Get.put(VisitorController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
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
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 2),
        child: Column(children: [
          TabBar(
              controller: _tabController,
              dividerColor: AppColors.purple,
              tabs: [
                Tab(
                    icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: "Pending  ",
                      fontSize: SizeUtils.fSize_10(),
                    ),
                    circleContainer(
                      child: CustomText(
                        title: "0",
                        fontSize: SizeUtils.fSize_11(),
                        color: AppColors.whiteColor,
                      ),
                    )
                  ],
                )),
                Tab(
                    icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: "Active  ",
                      fontSize: SizeUtils.fSize_10(),
                    ),
                    circleContainer(
                      child: CustomText(
                        title: "10",
                        fontSize: SizeUtils.fSize_11(),
                        color: AppColors.whiteColor,
                      ),
                    )
                  ],
                )),
                Tab(
                    icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: "Check Out",
                      fontSize: SizeUtils.fSize_10(),
                    )
                  ],
                )),
                Tab(
                    icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: "History  ",
                      fontSize: SizeUtils.fSize_10(),
                    ),
                    circleContainer(
                      child: CustomText(
                        title: "3",
                        fontSize: SizeUtils.fSize_11(),
                        color: AppColors.whiteColor,
                      ),
                    )
                  ],
                )),
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              //pending
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
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
                                Container(
                                    height: SizeUtils.verticalBlockSize *7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14)
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.asset(AppImage.profile))
                                ),
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
                                                fontSize: SizeUtils.fSize_10(),
                                                color: AppColors.grey80)),
                                      ],
                                      style: TextStyle(
                                          color: AppColors.black11A,
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeUtils.fSize_10()))),
                              const SizedBox(height: 6),
                              Row(children: [
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
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.black11A)),
                                      TextSpan(
                                          text: ' to ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.black11A)),
                                      TextSpan(
                                          text: '16:53:11',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeUtils.fSize_10(),
                                              color: AppColors.grey80)),
                                    ],
                                        style: TextStyle(
                                            color: AppColors.grey80,
                                            fontWeight: FontWeight.w400,
                                            fontSize: SizeUtils.fSize_10()))),

                                const Spacer(),
                                RichText(
                                    text: TextSpan(
                                        text: "Duration:",
                                        children: [
                                          TextSpan(
                                              text: ' 40m',
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
                              ])
                            ]),
                      ),
                    );
                  }),
              //active
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (index, context) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding:
                          EdgeInsets.all(SizeUtils.horizontalBlockSize * 2.4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 10)),
                          ]),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: SizeUtils.verticalBlockSize *7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14)
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(AppImage.profile))
                              ),
                              const SizedBox(width: 8),
                               Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     CustomText(
                                      title:'Rashmin kumar',
                                        fontSize: SizeUtils.fSize_13(),
                                        fontWeight: FontWeight.w700
                                    ),
                                    const SizedBox(height: 4),
                                     CustomText(
                                      title:'Active',
                                        color: AppColors.green,
                                        fontSize: SizeUtils.fSize_10(),
                                        fontWeight: FontWeight.w500
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time,
                                            size: 16, color: AppColors.grey80),
                                        const SizedBox(width: 2),
                                        CustomText(title:'12:14 PM',fontSize: SizeUtils.fSize_10(),color: AppColors.black11A,),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.call,
                                            size: 16, color: Colors.grey),
                                        const SizedBox(width: 2),
                                         CustomText(title:'6354223031',fontSize: SizeUtils.fSize_10(),color: AppColors.black11A,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              CustomButton(
                                onTap: () {},
                                title:'Check Out',
                                height: SizeUtils.verticalBlockSize * 3.6,
                                width: SizeUtils.horizontalBlockSize * 24,
                                borderColor: AppColors.grey80,
                                buttonColor: Colors.transparent,
                                fontSize: SizeUtils.fSize_10(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ActionIcon(Icons.print),
                              ActionIcon(Icons.remove_red_eye),
                              ActionIcon(Icons.edit),
                              ActionIcon(Icons.delete),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              //check out
              Container(
                color: AppColors.bgColor2,
                padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              size: SizeUtils.verticalBlockSize * 3,
                            ),
                            CustomText(
                              title: "  Visitor Details Scanner",
                              fontSize: SizeUtils.fSize_14(),
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
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
                          child: Row(
                            children: [
                              Expanded(child: borderContainer(onTap: () {
                                _visitorController.selectedIndex.value = 0;
                              })),
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 3),
                              Expanded(
                                  child: borderContainer(
                                      title: " QR Scanner",
                                      index: 1,
                                      icon: Icons.radio_button_on,
                                      onTap: () {
                                        _visitorController.selectedIndex.value =
                                            1;
                                      })),
                            ],
                          ),
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
                                size: SizeUtils.horizontalBlockSize * 8),
                          ),
                        ),
                        CustomText(
                            color: AppColors.grey80,
                            title: "Active Visitors",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w800),
                        ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.userDetailView);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.greyA6
                                              .withOpacity(0.4))),
                                  child: ListTile(
                                    title: CustomText(
                                        title: "Rashmin Kumar",
                                        fontSize: SizeUtils.fSize_13(),
                                        fontWeight: FontWeight.w800),
                                    subtitle:  CustomText(
                                        title: "Bhavani refractories",fontSize: SizeUtils.fSize_10()),
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
              ),
              //History
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (index, context) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding:
                          EdgeInsets.all(SizeUtils.horizontalBlockSize * 2.4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 10)),
                          ]),
                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar
                                Container(
                                    height: SizeUtils.verticalBlockSize *7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14)
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.asset(AppImage.profile))
                                ),
                                const SizedBox(width: 8),
                                 Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       CustomText(
                                        title: 'Rashmin kumar',
                                        color: AppColors.grey80,
                                        fontSize:SizeUtils.fSize_13(),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizedBox(height: 4),
                                       CustomText(
                                        title:'Check out',
                                         fontSize:SizeUtils.fSize_10(),
                                          color:AppColors.black11A,
                                          fontWeight: FontWeight.w500,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time,
                                              size: 16, color: AppColors.grey80),
                                          const SizedBox(width: 2),
                                          CustomText(title:'12:14 PM',fontSize: SizeUtils.fSize_10(),color: AppColors.black11A,),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.call,
                                              size: 16, color: Colors.grey),
                                          const SizedBox(width: 2),
                                          CustomText(title:'6354223031',fontSize: SizeUtils.fSize_10(),color: AppColors.black11A,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                CustomButton(
                                  onTap: () {},
                                  height: SizeUtils.verticalBlockSize * 3.6,
                                  width: SizeUtils.horizontalBlockSize * 24,
                                  fontSize:SizeUtils.fSize_10(),
                                   buttonColor: const Color(0xFFF0F0F0),
                                  title: 'Completed',
                                ),
                              ]),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ActionIcon(Icons.remove_red_eye),
                              ActionIcon(Icons.edit),
                              ActionIcon(Icons.delete),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ]),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(Routes.addVisitorView);
        },
        backgroundColor: AppColors.black11A,
        child: Icon(Icons.add,color: AppColors.whiteColor,size: SizeUtils.verticalBlockSize *4),
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
                title: title ?? " Manual Entry",
                color: AppColors.black11A,
                fontSize: SizeUtils.fSize_12())
          ]),
        ),
      ),
    );
  }

  Widget circleContainer({required Widget child}) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
          color: AppColors.black11A, shape: BoxShape.circle),
      child: child,
    );
  }
}

class ActionIcon extends StatelessWidget {
  final IconData icon;

  const ActionIcon(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: SizeUtils.verticalBlockSize * 2.2),
    );
  }
}
