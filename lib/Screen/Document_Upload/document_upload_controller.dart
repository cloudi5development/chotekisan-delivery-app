import 'dart:io';
import 'package:chotekisan_delivery_app/Screen/Vehicle_Information/vehicle_information_controller.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  Rxn<File> profilePhoto = Rxn<File>();
  Rxn<File> idProof = Rxn<File>();
  Rxn<File> drivingLicense = Rxn<File>();
  Rxn<File> vehicleRc = Rxn<File>();

  // License and RC are not needed for a bicycle
  bool get needsVehicleDocs => Get.isRegistered<VehicleInformationController>()
      ? Get.find<VehicleInformationController>().needsVehicleDocs
      : true;

  void showImageSourceSheet(BuildContext context, Rxn<File> target) {
    Get.bottomSheet(
      Material(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt_outlined),
                title: Text("Camera"),
                onTap: () {
                  Get.back();
                  pickImage(context, target, ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library_outlined),
                title: Text("Gallery"),
                onTap: () {
                  Get.back();
                  pickImage(context, target, ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(
    BuildContext context,
    Rxn<File> target,
    ImageSource source,
  ) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (file != null) {
        target.value = File(file.path);
      }
    } on PlatformException catch (e) {
      debugPrint("Image pick failed: ${e.code} ${e.message}");
      if (context.mounted) {
        showErrorSnackBar("Unable to open camera or gallery", context);
      }
    }
  }

  String? _validate() {
    if (profilePhoto.value == null) return "Please upload your photo";
    if (idProof.value == null) return "Please upload your government ID proof";
    if (needsVehicleDocs && drivingLicense.value == null) {
      return "Please upload your driving license";
    }
    if (needsVehicleDocs && vehicleRc.value == null) {
      return "Please upload your vehicle RC";
    }
    return null;
  }

  void onNext(BuildContext context) {
    final error = _validate();
    if (error != null) {
      showErrorSnackBar(error, context);
      return;
    }
    Get.toNamed(AppRoutes.paymentInformation);
  }

  void onBack() {
    Get.back();
  }
}
