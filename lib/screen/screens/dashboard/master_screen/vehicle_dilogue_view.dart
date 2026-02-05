import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/screen/screens/dashboard/master_screen/master_controller.dart';
import 'package:visitor_app/utils/size_utils.dart';
import 'package:visitor_app/widget/custom_button.dart';
import 'package:visitor_app/widget/custom_text.dart';
import 'package:visitor_app/widget/custom_textfield.dart';

class AddVehicleDialog extends StatelessWidget {
final bool? isEditVehicle;
final String? vehicleId;

  AddVehicleDialog({super.key,this.isEditVehicle = false,this.vehicleId});
  final MasterController _masterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 600,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CustomText(
                    title: 'Add Vehicle',
                    fontSize: SizeUtils.fSize_18(),
                    fontWeight: FontWeight.w600),
                GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, size: 22)),
              ]),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 24),
              const CustomText(
                  title: 'Vehicle Type *',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _masterController.vehicleController,
                hintText: "Enter vehicle type",
              ),
              const SizedBox(height: 30),
              const Divider(height: 1),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                /// CANCEL
                Expanded(
                  child: CustomButton(
                    buttonColor: AppColors.fillColor,
                    fontSize: SizeUtils.fSize_16(),
                    onTap: () => Get.back(),
                    title: 'Cancel',
                  ),
                ),
                const SizedBox(width: 16),
                /// UPDATE BUTTON
                Expanded(
                  child: CustomButton(
                    textColor: AppColors.whiteColor,
                    fontSize: SizeUtils.fSize_16(),
                    title: isEditVehicle  == true ? 'Update Vehicle' : 'Add Vehicle',
                    onTap: () async {
                      if(isEditVehicle == false){
                    await _masterController.createVehicle();
                      }else{
                        await _masterController.updateVehicleData(id: vehicleId);
                      }
                    Get.back();
                    },
                  ),
                ),
              ]),
            ]),
      ),
    );
  }
}
