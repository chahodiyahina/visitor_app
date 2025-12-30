import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_controller.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/utils/validation.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';

class AddVisitorView extends StatefulWidget {
  const AddVisitorView({super.key});

  @override
  State<AddVisitorView> createState() => _AddVisitorViewState();
}

class _AddVisitorViewState extends State<AddVisitorView> {
  final VisitorController _visitorController = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _visitorController.clearField();
    _visitorController.selectedDate.value = DateTime.now();
    _visitorController.dateController.text =
        _visitorController.formatDate(_visitorController.selectedDate.value);
    _visitorController.timeController.text =
        _visitorController.getCurrentTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
            title: "Add New Visitor", fontWeight: FontWeight.bold),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 2),
              child: Obx(
                () => Column(
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
                      Obx(() {
                        if (_visitorController.stepperIndex.value == 0 &&
                            _visitorController.imagePath.value.isNotEmpty) {
                          return Column(
                            children: [
                              Image.file(
                                  File(_visitorController.imagePath.value),
                                  height: 150,
                                  width: SizeUtils.screenWidth,
                                  fit: BoxFit.cover),
                              SizedBox(height: SizeUtils.verticalBlockSize * 2),
                            ],
                          );
                        }
                        if (_visitorController.stepperIndex.value == 1 &&
                            _visitorController.imagePath2.value.isNotEmpty) {
                          return Column(
                            children: [
                              Image.file(
                                  File(_visitorController.imagePath2.value),
                                  height: 150,
                                  width: SizeUtils.screenWidth,
                                  fit: BoxFit.cover),
                              SizedBox(height: SizeUtils.verticalBlockSize * 2),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      }),
                      _photoButtons(),
                      SizedBox(height: SizeUtils.verticalBlockSize * 2),
                      _bottomButtons(),
                      SizedBox(height: SizeUtils.verticalBlockSize * 2),
                    ]),
              )),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Wrap(
          spacing: 20,
          runSpacing: 16,
          children: [
            _field('Visitor Name *', 'Enter visitor\'s full name',
                _visitorController.vNameController,
                validator: AppValidator.nameValidator),
            _field('Mobile Number *', '+91 XXXXX XXXXX',
                _visitorController.moNumController,
                suffix: const Icon(Icons.search),
                validator: AppValidator.validateIndianMobile),
            _field('Email *', 'Enter email address',
                _visitorController.emailController,
                validator: AppValidator.emailValidator),
            _field('Company Name *', 'Enter company name',
                _visitorController.companyController,
                validator: AppValidator.comNameValidator),
            _field('No of Persons *', 'Enter number of persons',
                _visitorController.personNumController,
                validator: AppValidator.emptyField, suffix: _personNumField()),
            _field('Host Name *', 'Enter host name',
                _visitorController.hostNameController,
                validator: AppValidator.nameValidator),
            _field(
                'Site *', 'Gopin Semicon', _visitorController.siteController),
            _field('Gate Number *', '3', _visitorController.getNumController,
                validator: AppValidator.emptyField),
            _dateField('Date *'),
            _timeField('Time *'),

            // _field('Vehicle Number', 'Enter vehicle number',
            //     _visitorController.vehicleNoController),
            // _field('Vehicle Type', 'Enter host name',
            //     _visitorController.hostNameController),
            // _field('Item Type', 'Enter item type',
            //     _visitorController.hostNameController),
            // _field('No of Items', 'Enter number of items',
            //     _visitorController.hostNameController),
          ].map((e) {
            return SizedBox(
                width: isMobile
                    ? double.infinity
                    : (constraints.maxWidth / 2) - 12,
                child: e);
          }).toList(),
        );
      },
    );
  }

  Widget _formStepper2() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Wrap(
          spacing: 20,
          runSpacing: 16,
          children: [
            _field('Vehicle Number', 'Enter vehicle number',
                _visitorController.vehicleNoController,
                validator: AppValidator.nameValidator),
            _field('Vehicle Type', 'Select vehicle type',
                _visitorController.vehicleTypeController,
                suffix: const Icon(Icons.search),
                validator: AppValidator.validateIndianMobile),
            _field('Item Type', 'Enter item type',
                _visitorController.itemTypeController,
                validator: AppValidator.emailValidator),
            _field('No of Items', 'Enter number of items',
                _visitorController.noOfItemController,
                validator: AppValidator.comNameValidator),
          ].map((e) {
            return SizedBox(
                width: isMobile
                    ? double.infinity
                    : (constraints.maxWidth / 2) - 12,
                child: e);
          }).toList(),
        );
      },
    );
  }

  Widget _field(String label, String hint, TextEditingController controller,
      {Widget? suffix, FormFieldValidator<String>? validator}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(
          title: label,
          fontWeight: FontWeight.w600,
          fontSize: SizeUtils.fSize_12()),
      const SizedBox(height: 6),
      CustomTextField(
          controller: controller,
          fillColor: AppColors.whiteColor,
          validator: validator ?? AppValidator.emailValidator,
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

  Widget _dateField(String label) =>
      _field(label, '24/12/2025', _visitorController.dateController,
          suffix: GestureDetector(
              onTap: () {
                _visitorController.pickDate(context, (date) {
                  _visitorController.selectedDate.value =
                      date ?? DateTime.now();
                  _visitorController.dateController.text = _visitorController
                      .formatDate(_visitorController.selectedDate.value);
                });
              },
              child: const Icon(Icons.calendar_today)));

  Widget _timeField(String label) =>
      _field(label, '04 : 53 PM', _visitorController.timeController,
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
      icon: Icon(icon),
      label: Text(text),
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
                  : 'Create Pass', onPressed: () {
        _visitorController.clearField();
      })),
      const SizedBox(width: 12),
      Expanded(
          child: _actionBtn(
              _visitorController.stepperIndex.value == 0
                  ? 'Next'
                  : 'Print Pass',
              primary: true, onPressed: () {
        if (formKey.currentState!.validate()) {
        _visitorController.stepperIndex.value = 1;
        _visitorController.stepperIndex.refresh();
        }
        log("hello");
      })),
    ]);
  }

  Widget _actionBtn(String text,
      {bool primary = false, VoidCallback? onPressed}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? AppColors.green : AppColors.whiteColor,
          foregroundColor: primary ? AppColors.whiteColor : AppColors.black11A,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed ??
            () {
              _visitorController.stepperIndex.value = 1;
            },
        child: Text(text));
  }
}
