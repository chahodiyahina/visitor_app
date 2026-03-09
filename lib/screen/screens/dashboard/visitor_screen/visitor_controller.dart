import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:visitor_app/constant/endpoint_constant.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/models/searchSite_model.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/models/search_host_model.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/models/visitorDataOnMobile_model.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/models/visitor_model.dart';
import 'package:visitor_app/services/http_services.dart';
import 'package:visitor_app/utils/appUtilas.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_loading_dialog.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_toast.dart';

class VisitorController extends GetxController {
  late TabController tabController;
  RxInt selectedIndex = 0.obs;
  RxInt stepperIndex = 0.obs;
  RxString imagePath = "".obs;
  RxString imagePath2 = "".obs;
  RxInt increaseNoValue = 0.obs;
  RxBool isFormValid = false.obs;
  RxBool isDataGetOnMobNum = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  bool isFirstApiCall = true;
  RxInt selectedVisitorIndex = 0.obs;
  final List<String> vehicleTypeList = [
    'Select vehicle type',
    "Car",
    "Truck",
    "Motor Cyclr",
    "Plane",
    "Bike"
  ];
  RxString selectedVehicle = "".obs;

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
  Rx<TextEditingController> departmentController = TextEditingController().obs;
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  TextEditingController noOfItemController = TextEditingController();

  Rx<VisitorModel> visitorModel = VisitorModel().obs;
  Rx<SearchHostModel> searchHostModel = SearchHostModel().obs;
  Rx<SearchSiteModel> searchSiteModel = SearchSiteModel().obs;
  Rx<VisitorDataOnMObileModel> visitorDataOnMObileModel =
      VisitorDataOnMObileModel().obs;

  Future getImage(ImageSource source) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      if (stepperIndex.value == 0) {
        imagePath.value = pickedFile.path;
        log("get image from gallery :- ${imagePath.value}");
        imagePath.refresh();
      } else {
        imagePath2.value = pickedFile.path;
        log("get image 2222 from gallery :- ${imagePath2.value}");
      }
    }
    return "";
  }

  Future getImageCheckOut(ImageSource source, BuildContext context,
      {String? id}) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      customLoadingDialog();
      log("1111");
      String selectedFile = pickedFile.path;
      log("22222 :-$selectedFile");
      String? img = await AppUtils.fileToBase64(selectedFile);
      log("get image:-$img");
      updateAppointmentStatusCheckOutWithImage(context, id: id, img: img);
      customHideLoadingDialog();
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
    selectedVehicle.value = "";
    itemTypeController.clear();
    noOfItemController.clear();
    departmentController.value.clear();
    imagePath.value = "";
    imagePath2.value = "";
    stepperIndex.value = 0;
    isFormValid.value = false;
    isDataGetOnMobNum.value = false;
  }

  setDataInField(
      {String? name,
      String? mobileNum,
      String? email,
      String? companyName,
      String? noOfPerson,
      String? hostName,
      String? site,
      String? gateNumber,
      String? date,
      String? time,
      String? img1,
      String? vehicleNum,
      String? vehicleType,
      String? itemType,
      String? noOfItem,
      String? img2}) {
    vNameController.text = name ?? "";
    moNumController.text = mobileNum ?? "";
    emailController.text = email ?? "";
    companyController.text = companyName ?? "";
    personNumController.text = noOfPerson ?? "";
    hostNameController.text = hostName ?? "";
    siteController.text = site ?? "";
    getNumController.text = gateNumber ?? "";
    getNumController.text = gateNumber ?? "";
    dateController.text = date ?? "";
    timeController.text = time ?? "";
    noOfItemController.text = noOfItem ?? "";
    itemTypeController.text = itemType ?? "";
    vehicleNoController.text = vehicleNum ?? "";
    selectedVehicle.value = vehicleType ?? "";
    imagePath.value = img1 ?? "";
    imagePath2.value = img2 ?? "";
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

  checkValidate() {
    isFormValid.value = vNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        moNumController.text.length == 10 &&
        companyController.text.isNotEmpty &&
        personNumController.text.isNotEmpty &&
        hostNameController.text.isNotEmpty &&
        siteController.text.isNotEmpty &&
        getNumController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty;
  }

  Future getVisitorScreenData() async {
    try {
      if (isFirstApiCall) {
        customLoadingDialog();
        log("hello-----111");
      }
      var response =
          await HttpServices.getHttpMethod(url: ApiEndPoint.visitorDataGet);
      // log("Get home screen response data ::: ${response['body']} ");
      visitorModel.value = visitorModelFromJson(response['body']);
      log("Get home screen response data ::: ${visitorModel.value.toJson()} ");
      if (isFirstApiCall) {
        customHideLoadingDialog();
        isFirstApiCall = false;
        log("hello-----2222");
      }
    } catch (e, st) {
      if (isFirstApiCall) {
        customHideLoadingDialog();
        isFirstApiCall = false;
        log("hello-----3333");
      }
      log("home data get erro $e === $st ====");
    }
  }

  Future<void> getVisitorDataOnMobile(BuildContext context,
      {String? input}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.getVisitorDataOnMobile,
        data: {"mobileNumber": input},
      );
      if (response['error_description'] == null) {
        log("getVisitorDataOnMobile SUCCESS ::: ${response['body']}");
        visitorDataOnMObileModel.value =
            visitorDataOnMObileModelFromJson(response['body']);
        VisitorData? data = visitorDataOnMObileModel.value.visitorData;
        setDataInField(
            name: data?.name,
            mobileNum: data?.mobileNumber,
            email: data?.email,
            companyName: data?.companyName,
            noOfPerson: data?.totalPerson?.toString(),
            hostName: data?.host,
            site: data?.entryPlace,
            gateNumber: data?.entryGate,
            // date: AppUtils.formatDateFormat(dateController.text.trim()),
            date: AppUtils.formatDate(data?.date ?? DateTime.now()),
            time: data?.time,
            img1: data?.imagePath,
            vehicleNum: data?.vehicleNumber,
            vehicleType: data?.vehicleType,
            // itemType: data?.itemTypes,
            // noOfItem: data?.numberOfItems,
            img2: data?.identityProofImage);
        isDataGetOnMobNum.value = true;
      } else {
        log("getVisitorDataOnMobile FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("getVisitorDataOnMobile ERROR ::: $e === $st");
    }
  }

  Future<List<String>> searchHost(BuildContext context, {String? input}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.searchHostName,
        data: {"search_name": input?.trim() ?? ""},
      );
      if (response['error_description'] == null) {
        log("searchHost SUCCESS ::: ${response['body']}");
        searchHostModel.value = searchHostModelFromJson(response['body']);
        return searchHostModel.value.userList
                ?.map((e) => e.name ?? '')
                .where((name) => name.isNotEmpty)
                .toList() ??
            [];
      } else {
        log("searchHost FAILED ::: ${response['error_description']}");
        return ["No host name found"];
      }
    } catch (e, st) {
      log("searchHost ERROR ::: $e === $st");
      return ["No host name found"];
    }
  }

  Future<List<String>> searchSite(BuildContext context, {String? input}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.searchSiteName,
        data: {"site_name": input?.trim() ?? ""},
      );
      if (response['error_description'] == null) {
        log("searchHost SUCCESS ::: ${response['body']}");
        searchSiteModel.value = searchSiteModelFromJson(response['body']);
        return searchSiteModel.value.siteNameList ?? [];
      } else {
        log("searchHost FAILED ::: ${response['error_description']}");
        return ["No host name found"];
      }
    } catch (e, st) {
      log("searchHost ERROR ::: $e === $st");
      return ["No host name found"];
    }
  }

  Future<void> addVisitor(BuildContext context, {String? input}) async {
    try {
      customLoadingDialog();
      String? base64Image1;
      String? base64Image2;
      if (imagePath.value.isNotEmpty) {
        base64Image1 = await AppUtils.fileToBase64(imagePath.value);
      }
      if (imagePath2.value.isNotEmpty) {
        base64Image2 = await AppUtils.fileToBase64(imagePath2.value);
      }

      Map<String, dynamic> data = {
        "name": vNameController.text.trim(),
        "mobileNumber": moNumController.text.trim(),
        "email": emailController.text.trim(),
        "companyName": companyController.text.trim(),
        "vehicleNumber": vehicleNoController.text.trim(),
        "vehicleType": selectedVehicle.value,
        "itemTypes": itemTypeController.text.trim(),
        "numberOfItems": noOfItemController.text.trim(),
        "host": hostNameController.text.trim(),
        "department": departmentController.value.text.trim(),
        "date": dateController.text.isNotEmpty
            ? AppUtils.formatDateFormat(dateController.text.trim())
            : "",
        "time": timeController.text.trim(),
        // "image": "data:image/jpeg;base64,$base64Image1",
        // "identityProofImage": "data:image/jpeg;base64,$base64Image2",
        "totalPerson": personNumController.text.trim(),
        "entryPlace": siteController.text.trim(),
        "entryGate": getNumController.text.trim(),
      };

      if (base64Image1 != null) {
        data["image"] = "data:image/jpeg;base64,$base64Image1";
      }
      if (base64Image2 != null) {
        data["identityProofImage"] = "data:image/jpeg;base64,$base64Image2";
      }
      log("create visitor data:-$data");
      final response = await HttpServices.postHttpMethod(
          url: ApiEndPoint.createVisitor, data: data);
      if (response['error_description'] == null) {
        log("addVisitor SUCCESS ::: ${response['body']}");
        await getVisitorScreenData();
        customHideLoadingDialog();
        clearField();
        Get.back();
      } else {
        customHideLoadingDialog();
        log("addVisitor FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      customHideLoadingDialog();
      log("addVisitor ERROR ::: $e === $st");
    }
  }

  Future<void> updateVisitor(BuildContext context, {dynamic id}) async {
    try {
      customLoadingDialog();
      String? base64Image2;
      String? base64Image1;
      if (imagePath.value.startsWith("https://") ||
          imagePath2.value.startsWith("https://")) {
        base64Image2 = await AppUtils.imageUrlToBase64(imagePath2.value);
        base64Image1 = await AppUtils.imageUrlToBase64(imagePath.value);
        log("base url image:-$base64Image1 ==== $base64Image2");
      } else {
        base64Image1 = await AppUtils.fileToBase64(imagePath.value);
        base64Image2 = await AppUtils.fileToBase64(imagePath2.value);
      }
      Map<String, dynamic> data = {
        "name": vNameController.text.trim(),
        "mobileNumber": moNumController.text.trim(),
        "email": emailController.text.trim(),
        "companyName": companyController.text.trim(),
        "vehicleNumber": vehicleNoController.text.trim(),
        "vehicleType": selectedVehicle.value,
        "itemTypes": itemTypeController.text.trim(),
        "numberOfItems": noOfItemController.text.trim(),
        "host": hostNameController.text.trim(),
        "department": departmentController.value.text.trim(),
        "date": dateController.text.isNotEmpty
            ? AppUtils.formatDateFormat(dateController.text.trim())
            : "",
        "time": timeController.text.trim(),
        "image": "data:image/jpeg;base64,$base64Image1",
        "identityProofImage": "data:image/jpeg;base64,$base64Image2",
        "totalPerson": personNumController.text.trim(),
        "entryPlace": siteController.text.trim(),
        "entryGate": getNumController.text.trim(),
      };
      log("updateVisitor  data:-$data");
      final response = await HttpServices.putHttpMethod(
          url: ApiEndPoint.updateVisitor + (id.toString()), data: data);
      if (response['error_description'] == null) {
        log("updateVisitor SUCCESS ::: ${response['body']}");
        await getVisitorScreenData();
        CustomToast.successToast(
            message: "Update successfully", context: context);
        clearField();
        customHideLoadingDialog();
        Get.back();
      } else {
        customHideLoadingDialog();
        log("updateVisitor FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      customHideLoadingDialog();
      log("updateVisitor ERROR ::: $e === $st");
    }
  }

  Future<void> deleteVisitorAppointment(BuildContext context,
      {String? id}) async {
    try {
      customLoadingDialog();
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.appointmentDelete,
        data: {"id": id},
      );
      if (response['error_description'] == null) {
        log("deleteVisitorAppointment SUCCESS ::: ${response['body']}");
        customHideLoadingDialog();
        await getVisitorScreenData();
        CustomToast.successToast(
            message: "Delete visitor appointment successfully",
            context: context);
      } else {
        customHideLoadingDialog();
        log("deleteVisitorAppointment FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      customHideLoadingDialog();
      log("deleteVisitorAppointment ERROR ::: $e === $st");
    }
  }

  Future<void> updateAppointmentStatusCheckIn(BuildContext context,
      {String? id}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.updateAppointmentStatusCheckIn,
        data: {"id": id},
      );
      if (response['error_description'] == null) {
        log("updateAppointmentStatusCheckIn SUCCESS ::: ${response['body']}");
        await getVisitorScreenData();
      } else {
        log("updateAppointmentStatusCheckIn FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("updateAppointmentStatusCheckIn ERROR ::: $e === $st");
    }
  }

  Future<void> updateAppointmentStatusCheckOutWithImage(BuildContext context,
      {String? id, String? img}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.updateAppointmentStatusCheckOutWithImage,
        data: {"id": id, "checkout_image": img},
      );
      if (response['error_description'] == null) {
        log("updateAppointmentStatusCheckOutWithImage SUCCESS ::: ${response['body']}");
        await getVisitorScreenData();
      } else {
        log("updateAppointmentStatusCheckOutWithImage FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("updateAppointmentStatusCheckOutWithImage ERROR ::: $e === $st");
    }
  }

  Future<void> updateAppointmentStatusDirectCheckOut(BuildContext context,
      {String? id}) async {
    try {
      customLoadingDialog();
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.updateAppointmentStatusDirectCheckOut,
        data: {"id": id},
      );
      if (response['error_description'] == null) {
        log("updateAppointmentStatusDirectCheckOut SUCCESS ::: ${response['body']}");
        await getVisitorScreenData();
        customHideLoadingDialog();
      } else {
        customHideLoadingDialog();
        log("updateAppointmentStatusDirectCheckOut FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      customHideLoadingDialog();
      log("updateAppointmentStatusDirectCheckOut ERROR ::: $e === $st");
    }
  }

  Future<void> updateAppointmentStatusApproval(BuildContext context,
      {String? id}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.updateAppointmentStatusApproval,
        data: {"id": id},
      );
      if (response['error_description'] == null) {
        log("updateAppointmentStatusApproval SUCCESS ::: ${response['body']}");
        await getVisitorScreenData();
      } else {
        log("updateAppointmentStatusApproval FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("updateAppointmentStatusApproval ERROR ::: $e === $st");
    }
  }

  Future<void> updateAppointmentStatusRejected(BuildContext context,
      {String? id}) async {
    try {
      final response = await HttpServices.postHttpMethod(
        url: ApiEndPoint.updateAppointmentStatusRejected,
        data: {"id": id},
      );
      if (response['error_description'] == null) {
        log("updateAppointmentStatusRejected SUCCESS ::: ${response['body']}");
        await getVisitorScreenData();
      } else {
        log("updateAppointmentStatusRejected FAILED ::: ${response['error_description']}");
      }
    } catch (e, st) {
      log("updateAppointmentStatusRejected ERROR ::: $e === $st");
    }
  }

  ///date picker =====
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
                onSurface: Colors.black),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
            ),
          ),
          child: child!,
        );
      },
    );
    onDateSelected(picked);
  }

  String getCurrentTime() {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  ///date picker end ====

  ///Time picker
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
                  _timePicker(
                      context,
                      List.generate(
                          12, (i) => (i + 1).toString().padLeft(2, '0')),
                      hour - 1,
                      (i) => hour = i + 1),
                  _timePicker(
                      context,
                      List.generate(60, (i) => i.toString().padLeft(2, '0')),
                      minute,
                      (i) => minute = i),
                  _timePicker(context, ["AM", "PM"], period == "AM" ? 0 : 1,
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

  Widget _timePicker(
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

  ///Time picker end ====
}
