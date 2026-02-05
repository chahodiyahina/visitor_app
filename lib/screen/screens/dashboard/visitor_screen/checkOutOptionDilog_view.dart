import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitor_app/constant/app_color.dart';
import 'package:visitor_app/screen/screens/dashboard/visitor_screen/visitor_controller.dart';
import 'package:visitor_app/widget/custom_loading_dialog.dart';

class CheckoutOptionsDialog extends StatelessWidget {
  String? id;

  CheckoutOptionsDialog({super.key, this.id});

  final VisitorController _visitorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                size: 28,
                color: AppColors.infoToastSideColor,
              ),
            ),

            const SizedBox(height: 16),

            /// TITLE
            const Text(
              "Checkout Options",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            /// SUBTITLE
            const Text(
              "Proceed with the visitor checkout.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            /// BUTTON ROW
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      customLoadingDialog();
                      _visitorController.getImageCheckOut(
                          ImageSource.camera, context,
                          id: id);
                      customHideLoadingDialog();
                    },
                    child: Text(
                      "Capture Pass",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
