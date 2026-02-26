import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/models/visitor_model.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/pdf_view.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_controller.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/appUtilas.dart';
import 'package:visitor_app/utils/app_string.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/utils/validation.dart';
import 'package:visitor_app/widget/custom_TypleAhedField.dart';
import 'package:visitor_app/widget/custom_cachedImage.dart';
import 'package:visitor_app/widget/custom_dropdown.dart';
import 'package:visitor_app/widget/custom_loading_dialog.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';

class AddVisitorView extends StatefulWidget {
  const AddVisitorView({super.key});

  @override
  State<AddVisitorView> createState() => _AddVisitorViewState();
}

class _AddVisitorViewState extends State<AddVisitorView> {
  late final VisitorController _visitorController = Get.find();
  final formKey = GlobalKey<FormState>();
  String getType = "";
  dynamic id;
  VisitorList? data11;

  @override
  void initState() {
    _visitorController.clearField();
    _visitorController.selectedVehicle.value =
        _visitorController.vehicleTypeList.first;
    getType = Get.arguments ?? "";
    log("get arguments:- $getType");
    if (getType != "add") {
      fillVisitorData(getType);
    } else {
      _visitorController.clearField();
      _visitorController.selectedDate.value = DateTime.now();
      _visitorController.dateController.text =
          AppUtils.formatDate(_visitorController.selectedDate.value);
      _visitorController.timeController.text =
          _visitorController.getCurrentTime();
    }
    super.initState();
  }

  VisitorList? _getVisitorByType(String type) {
    final model = _visitorController.visitorModel.value;
    final index = _visitorController.selectedVisitorIndex.value;

    switch (type) {
      case AppString.visitor:
        return model.pendingVisitorList?[index];
      case AppString.active:
        return model.activeVisitorList?[index];
      case AppString.history:
        return model.historyVisitorList?[index];
      default:
        return null;
    }
  }

  void fillVisitorData(String type) {
    data11 = _getVisitorByType(type);
    log("get data in screen:-${data11?.name}");
    final data = _getVisitorByType(type);
    log("get data in screen:-$data");
    if (data == null) return;
    _visitorController.setDataInField(
      name: data.name,
      mobileNum: data.mobileNumber,
      email: data.email,
      companyName: data.companyName,
      noOfPerson: data.totalPerson?.toString(),
      hostName: data.host,
      site: data.entryPlace,
      gateNumber: data.entryGate,
      date: AppUtils.formatDate(data.date ?? DateTime.now()),
      time: data.time,
      img1: data.imagePath,
      vehicleNum: data.vehicleNumber,
      vehicleType: data.vehicleType,
      itemType: data.itemTypes,
      noOfItem: data.numberOfItems,
      img2: data.identityProofImage,
    );
    id = data.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        title: const CustomText(
            title: "Add New Visitor", fontWeight: FontWeight.bold),
      ),
      body: Form(
        key: formKey,
        onChanged: () {
          _visitorController.checkValidate();
        },
        child: Obx(
          () => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 3),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeUtils.verticalBlockSize * 2),
                    _stepper(),
                    SizedBox(height: SizeUtils.verticalBlockSize * 2),
                    if (_visitorController.stepperIndex.value == 0)
                      Flexible(child: _formStepper1()),
                    if (_visitorController.stepperIndex.value == 1)
                      Flexible(child: _formStepper2()),
                    SizedBox(height: SizeUtils.verticalBlockSize * 2),
                    if (_visitorController.stepperIndex.value == 1)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeUtils.verticalBlockSize * 1),
                        child: CustomText(
                            title: "Identification Photo",
                            fontWeight: FontWeight.w600,
                            fontSize: SizeUtils.fSize_12()),
                      ),
                    if (_visitorController.stepperIndex.value == 0 &&
                        _visitorController.imagePath.value.isNotEmpty)
                      Column(children: [
                        (_visitorController.imagePath.value
                                .startsWith("https://"))
                            ? CustomCachedImage(
                                imageUrl: _visitorController.imagePath.value,
                                height: 150,
                                width: SizeUtils.screenWidth,
                                fit: BoxFit.cover)
                            : Image.file(
                                File(_visitorController.imagePath.value),
                                height: 150,
                                width: SizeUtils.screenWidth,
                                fit: BoxFit.cover),
                        SizedBox(height: SizeUtils.verticalBlockSize * 2),
                      ]),
                    if (_visitorController.stepperIndex.value == 1 &&
                        _visitorController.imagePath2.value.isNotEmpty)
                      Column(children: [
                        _visitorController.imagePath2.value
                                .startsWith("https://")
                            ? CustomCachedImage(
                                imageUrl: _visitorController.imagePath2.value,
                                height: 150,
                                width: SizeUtils.screenWidth,
                                fit: BoxFit.cover)
                            : Image.file(
                                File(_visitorController.imagePath2.value),
                                height: 150,
                                width: SizeUtils.screenWidth,
                                fit: BoxFit.cover),
                        SizedBox(height: SizeUtils.verticalBlockSize * 2),
                      ]),
                    _photoButtons(),
                    SizedBox(height: SizeUtils.verticalBlockSize * 2),
                    _bottomButtons(),
                    SizedBox(height: SizeUtils.verticalBlockSize * 2),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepper() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _stepCircle(
          '1',
          'Visitor Info',
          _visitorController.stepperIndex.value == 0 ||
              _visitorController.stepperIndex.value == 1),
      Container(
          width: 40,
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          color: AppColors.greyA6),
      _stepCircle(
          '2', 'Vehicle Info', _visitorController.stepperIndex.value == 1),
    ]);
  }

  Widget _stepCircle(String step, String label, bool active) {
    return Row(children: [
      CircleAvatar(
        radius: 12,
        backgroundColor: active ? AppColors.green : AppColors.greyA6,
        child: CustomText(
            title: step,
            color: AppColors.whiteColor,
            fontSize: SizeUtils.fSize_11()),
      ),
      const SizedBox(width: 6),
      CustomText(
          title: label,
          // fontSize: SizeUtils.fSize_11(),
          color: active ? AppColors.green : AppColors.greyA6,
          fontWeight: FontWeight.w600),
    ]);
  }

  Widget _formStepper1() {
    final width = MediaQuery.of(Get.context!).size.width;
    final isMobile = width < 700;

    return Wrap(
      spacing: 20,
      runSpacing: 16,
      children: [
        _field('Visitor Name *', 'Enter visitor\'s full name',
            _visitorController.vNameController,
            validator: AppValidator.nameValidator),

        _field('Mobile Number *', '+91 XXXXX XXXXX',
            _visitorController.moNumController,
            suffix: GestureDetector(
                onTap: () async {
                  if (_visitorController.moNumController.text.isNotEmpty) {
                    await _visitorController.getVisitorDataOnMobile(context,
                        input: _visitorController.moNumController.text);
                  }
                },
                child: const Icon(Icons.search)),
            keyboardType: TextInputType.number,
            validator: AppValidator.validateIndianMobile),

        _field(
          'Email',
          'Enter email address',
          _visitorController.emailController,
          keyboardType: TextInputType
              .emailAddress, /*validator: AppValidator.emailValidator*/
        ),

        _field('Company Name *', 'Enter company name',
            _visitorController.companyController,
            validator: AppValidator.comNameValidator),

        _field(
          'No of Persons *',
          'Enter number of persons',
          _visitorController.personNumController,
          isNum: true,
          keyboardType: TextInputType.number,
          validator: AppValidator.emptyField,
          suffix: _personNumField(),
        ),

        // Host Name
        CustomText(
            title: 'Host Name *',
            fontWeight: FontWeight.w600,
            fontSize: SizeUtils.fSize_12()),

        _hostNameTypeAhead(),

        Obx(() => _visitorController.departmentController.value.text.isNotEmpty
            ? _field(
                'Department', '', _visitorController.departmentController.value,
                validator: AppValidator.siteValidator)
            : const SizedBox()),

        // _field('Site *', 'Gopin Semicon', _visitorController.siteController,
        //     validator: AppValidator.siteValidator),
        // site Name
        CustomText(
            title: 'Site *',
            fontWeight: FontWeight.w600,
            fontSize: SizeUtils.fSize_12()),
        _siteTypeAhead(),

        _field('Gate Number *', '3', _visitorController.getNumController,
            validator: AppValidator.emptyField),

        _dateField('Date *'),
        _timeField('Time *'),
      ].map((e) {
        return SizedBox(
          width: isMobile ? double.infinity : (width / 2) - 12,
          child: e,
        );
      }).toList(),
    );
  }

  Widget _hostNameTypeAhead() {
    return CustomTypeAheadField(
      controller: _visitorController.hostNameController,
      hintText: "Host Name",
      suggestionsCallback: (query) async {
        return await _visitorController.searchHost(
          context,
          input: query.trim(),
        );
      },
      onSelected: (value) {
        _visitorController.hostNameController.text = value;
        final index = _visitorController.searchHostModel.value.userList!
            .indexWhere((e) => e.name == value);
        _visitorController.departmentController.value.text = _visitorController
                .searchHostModel.value.userList?[index].department ??
            "";
        _visitorController.departmentController.refresh();
      },
    );
  }

  Widget _siteTypeAhead() {
    return CustomTypeAheadField(
      controller: _visitorController.siteController,
      hintText: 'Enter site name',
      suggestionsCallback: (query) async {
        return await _visitorController.searchSite(context,
            input: query.trim());
      },
      onSelected: (value) {
        _visitorController.siteController.text = value;
      },
    );
  }

  Widget _formStepper2() {
    final width = MediaQuery.of(Get.context!).size.width;
    final isMobile = width < 700;

    return Wrap(
      spacing: 20,
      runSpacing: 16,
      children: [
        _field('Vehicle Number', 'Enter vehicle number',
            _visitorController.vehicleNoController,
            validator: AppValidator.nameValidator),
        CustomText(
            title: "Vehicle Type",
            fontWeight: FontWeight.w600,
            fontSize: SizeUtils.fSize_12()),
        CustomDropdownField(
          hint: 'Select vehicle type',
          items: _visitorController.vehicleTypeList,
          value: _visitorController.selectedVehicle.value,
          onChanged: (value) {
            _visitorController.selectedVehicle.value =
                value ?? _visitorController.vehicleTypeList.first;
          },
          validator: (value) {
            if (value == null) return 'Please select role.';
            return null;
          },
        ),
        _field('Item Type', 'Enter item type',
            _visitorController.itemTypeController,
            validator: AppValidator.emptyField),
        _field('No of Items', 'Enter number of items',
            _visitorController.noOfItemController,
            validator: AppValidator.emptyField),
      ].map((e) {
        return SizedBox(
          width: isMobile ? double.infinity : (width / 2) - 12,
          child: e,
        );
      }).toList(),
    );
  }

  Widget _field(
    String label,
    String hint,
    TextEditingController controller, {
    Widget? suffix,
    FormFieldValidator<String>? validator,
    bool? isNum,
    bool? isRead,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(
          title: label,
          fontWeight: FontWeight.w600,
          fontSize: SizeUtils.fSize_12()),
      const SizedBox(height: 6),
      CustomTextField(
          controller: controller,
          isNumber: isNum ?? false,
          keyboardType: keyboardType,
          hintText: hint,
          readOnly: isRead ?? false,
          fillColor: AppColors.fillColor,
          validator: validator,
          suffixIcon: suffix),
    ]);
  }

  Widget _personNumField() => Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.greyA6.withAlpha(36),
        ),
        child: Column(children: [
          GestureDetector(
              onTap: () {
                _visitorController.increase();
              },
              child: const Icon(Icons.keyboard_arrow_up)),
          GestureDetector(
              onTap: () {
                _visitorController.decrease();
              },
              child: const Icon(Icons.keyboard_arrow_down))
        ]),
      );

  Widget _dateField(String label) {
    log("get date :-${_visitorController.dateController.text}");
    return _field(label, '24/12/2025', _visitorController.dateController,
        isNum: true,
        keyboardType: TextInputType.datetime,
        validator: AppValidator.emptyField,
        suffix: GestureDetector(
            onTap: () {
              _visitorController.pickDate(context, (date) {
                _visitorController.selectedDate.value = date ?? DateTime.now();
                _visitorController.dateController.text =
                    AppUtils.formatDate(_visitorController.selectedDate.value);
              });
            },
            child: const Icon(Icons.calendar_today)));
  }

  Widget _timeField(String label) =>
      _field(label, '04 : 53 PM', _visitorController.timeController,
          isRead: true,
          validator: AppValidator.emptyField,
          suffix: GestureDetector(
              onTap: () async {
                final time =
                    await _visitorController.showCustomTimePicker(context);
                if (time != null) {
                  _visitorController.timeController.text = time;
                }
              },
              child: const Icon(Icons.access_time)));

  Widget _photoButtons() {
    return Row(children: [
      _iconBtn(Icons.camera_alt, 'Take Photo', onPressed: () async {
        await _visitorController.getImage(ImageSource.camera);
      }),
      const SizedBox(width: 10),
      _iconBtn(Icons.upload, 'Select Photo', onPressed: () async {
        await _visitorController.getImage(ImageSource.gallery);
      }),
    ]);
  }

  Widget _iconBtn(IconData icon, String text,
      {bool outlined = false, VoidCallback? onPressed}) {
    return OutlinedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, color: AppColors.black11A),
      label: CustomText(title: text),
      style: OutlinedButton.styleFrom(
        side: outlined ? const BorderSide(color: Colors.green) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _bottomButtons() {
    return Row(children: [
      Expanded(
          child: _actionBtn(
              _visitorController.stepperIndex.value == 0 ? 'Cancel' : 'Back',
              onPressed: () {
        if (_visitorController.stepperIndex.value == 0) {
          _visitorController.clearField();
          Get.back();
        } else {
          _visitorController.stepperIndex.value = 0;
        }
      })),
      const SizedBox(width: 12),
      Expanded(
          child: _actionBtn(
              _visitorController.stepperIndex.value == 0
                  ? 'Clear'
                  : 'Create Pass', onPressed: () async {
        if (_visitorController.stepperIndex.value == 0) {
          _visitorController.clearField();
        }
        if (_visitorController.stepperIndex.value == 1) {
          if (getType == "add") {
            await _visitorController.addVisitor(context);
          } else if (getType != "add") {
            await _visitorController.updateVisitor(context, id: id ?? "");
          }
        }
      })),
      const SizedBox(width: 12),
      Expanded(
        child: _actionBtn(
            _visitorController.stepperIndex.value == 0 ? 'Next' : 'Print Pass',
            primary: _visitorController.isFormValid.value, onPressed: () async {
          if (_visitorController.stepperIndex.value == 1) {
            customLoadingDialog();
            Uint8List? imageBytes;
            final imagePath = _visitorController.imagePath.value.isNotEmpty
                ? _visitorController.imagePath.value
                : data11?.imagePath;
            if (imagePath != null && imagePath.isNotEmpty) {
              imageBytes = await AppUtils.imageUrlToUint8List(imagePath);
            }
            generateVisitorPassPdf(
                    hostName: _visitorController.hostNameController.text.trim(),
                    vehicleType: _visitorController.selectedVehicle.value,
                    vehicleNo:
                        _visitorController.vehicleNoController.text.trim(),
                    visitorName: _visitorController.vNameController.text.trim(),
                    badgeNo: data11?.badgeNumber ?? "-",
                    mobile: _visitorController.moNumController.text.trim(),
                    company: _visitorController.companyController.text.trim(),
                    checkInTime: _visitorController.dateController.text.trim(),
                    department: _visitorController
                        .departmentController.value.text
                        .trim(),
                    site: _visitorController.siteController.text.trim(),
                    gate: _visitorController.getNumController.text.trim(),
                    itemType: _visitorController.itemTypeController.text.trim(),
                    itemNumber: data11?.numberOfItems ?? "-",
                    photo: imageBytes)
                .then((file) async {
              final pdfFile = File(file.path);
              if (pdfFile.existsSync()) {
                // Proceed to open the PDF
                await OpenFile.open(pdfFile.path);
              }
              customHideLoadingDialog();
            });
          }

          if (_visitorController.stepperIndex.value == 0) {
            if (formKey.currentState!.validate()) {
              _visitorController.stepperIndex.value = 1;
              _visitorController.stepperIndex.refresh();
            }
          }
        }),
      ),
    ]);
  }

  Widget _actionBtn(String text,
      {bool primary = false, VoidCallback? onPressed}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? AppColors.green : AppColors.whiteColor,
          // foregroundColor: primary ? AppColors.whiteColor : AppColors.black11A,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed ??
            () {
              _visitorController.stepperIndex.value = 1;
            },
        child: CustomText(
            title: text,
            fontSize: SizeUtils.fSize_11(),
            color: primary ? AppColors.whiteColor : AppColors.black11A));
  }
}
