import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_text.dart';

class VisitorController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt stepperIndex = 0.obs;
  RxString imagePath = "".obs;
  RxString imagePath2 = "".obs;
  RxInt increaseNoValue = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController vNameController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController moNumController = TextEditingController();
  TextEditingController getNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController personNumController = TextEditingController();
  TextEditingController hostNameController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  TextEditingController noOfItemController = TextEditingController();

  // Future<void> getImage(ImageSource source) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: source);
  //
  //   if (pickedFile != null) {
  //     imagePath.value = pickedFile.path;
  //     log("Image saved at: ${imagePath.value}");
  //   }
  // }

  Future getImage(ImageSource source) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      if(stepperIndex.value == 0) {
        imagePath.value = pickedFile.path;
        log("get image from gallery :- ${imagePath.value}");
      }else{
        imagePath2.value = pickedFile.path;
        log("get image 2222 from gallery :- ${imagePath2.value}");
      }
    }
    return "";
  }

  clearField() {
    searchController.clear();
    vNameController.clear();
    siteController.clear();
    moNumController.clear();
    getNumController.clear();
    emailController.clear();
    dateController.clear();
    timeController.clear();
    companyController.clear();
    personNumController.clear();
    hostNameController.clear();
    vehicleNoController.clear();
    vehicleTypeController.clear();
    itemTypeController.clear();
    noOfItemController.clear();
    imagePath.value = "";
    imagePath2.value = "";
    stepperIndex.value = 0;
  }

  void increase() {
    increaseNoValue++;
    personNumController.text = increaseNoValue.value.toString();
  }

  void decrease() {
    if (increaseNoValue > 1) {
      increaseNoValue--;
      personNumController.text = increaseNoValue.value.toString();
    }
  }

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
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    onDateSelected(picked);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String getCurrentTime() {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  ///date picker end ====

  Future<String?> showCustomTimePicker(BuildContext context) async {
    int hour = 3;
    int minute = 25;
    String period = "PM";

    return showDialog<String>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 300,
            child: Column(children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(12),
                child: CustomText(
                    title:
                        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              Expanded(
                child: Row(children: [
                  _picker(
                      context,
                      List.generate(
                          12, (i) => (i + 1).toString().padLeft(2, '0')),
                      hour - 1,
                      (i) => hour = i + 1),
                  _picker(
                      context,
                      List.generate(60, (i) => i.toString().padLeft(2, '0')),
                      minute,
                      (i) => minute = i),
                  _picker(context, ["AM", "PM"], period == "AM" ? 0 : 1,
                      (i) => period = i == 0 ? "AM" : "PM"),
                ]),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period",
                  );
                },
                child: CustomText(title: "OK", fontSize: SizeUtils.fSize_16()),
              ),
            ]),
          ),
        );
      },
    );
  }

  Widget _picker(
    BuildContext context,
    List<String> items,
    int initialIndex,
    Function(int) onSelected,
  ) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40,
        scrollController:
            FixedExtentScrollController(initialItem: initialIndex),
        onSelectedItemChanged: onSelected,
        selectionOverlay: Container(
          decoration: BoxDecoration(
              color: Colors.blue.withAlpha(20),
              borderRadius: BorderRadius.circular(6)),
        ),
        children: items
            .map(
              (e) => Center(
                child: CustomText(title: e, fontSize: 18),
              ),
            )
            .toList(),
      ),
    );
  }
}
