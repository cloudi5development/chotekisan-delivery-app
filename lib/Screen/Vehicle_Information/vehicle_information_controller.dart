import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleInformationController extends GetxController {
  // 0 = Bike, 1 = Scooter, 2 = Electric Vehicle, 3 = Bicycle
  RxInt vehicleType = 0.obs;
  final TextEditingController vehicleNumberController = TextEditingController();

  final List<Map<String, String>> vehicleList = [
    {"name": "Bike", "icon": AssetSvgPath.bikeIcon},
    {"name": "Scooter", "icon": AssetSvgPath.scooter},
    {"name": "Electric Vehicle", "icon": AssetSvgPath.evBike},
    {"name": "Bicycle", "icon": AssetSvgPath.cycle},
  ];

  // License, RC and registration number are not needed for a bicycle
  bool get needsVehicleDocs => vehicleType.value != 3;

  void onNext(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (needsVehicleDocs && vehicleNumberController.text.trim().isEmpty) {
      showErrorSnackBar(
        "Please enter your vehicle registration number",
        context,
      );
      return;
    }
    Get.toNamed(AppRoutes.documentUpload);
  }

  void onBack() {
    Get.back();
  }

  @override
  void onClose() {
    vehicleNumberController.dispose();
    super.onClose();
  }
}
