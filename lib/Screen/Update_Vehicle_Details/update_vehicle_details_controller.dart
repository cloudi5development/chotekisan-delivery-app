import 'package:chotekisan_delivery_app/Screen/Vehicle_Details/vehicle_details_controller.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateVehicleDetailsController extends GetxController {
  // 0 = Bike, 1 = Scooter, 2 = Electric Vehicle, 3 = Bicycle
  RxInt vehicleType = 1.obs;

  final TextEditingController vehicleNumberController =
      TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController rcNumberController = TextEditingController();
  final TextEditingController registrationDateController =
      TextEditingController();
  final TextEditingController insuranceValidityController =
      TextEditingController();
  final TextEditingController pucValidityController = TextEditingController();

  final List<Map<String, String>> vehicleList = [
    {"name": "Bike", "icon": AssetSvgPath.bikeIcon},
    {"name": "Scooter", "icon": AssetSvgPath.scooter},
    {"name": "Electric Vehicle", "icon": AssetSvgPath.evBike},
    {"name": "Bicycle", "icon": AssetSvgPath.cycle},
  ];

  @override
  void onInit() {
    super.onInit();
    // Prefill from the saved details when opened from the details screen.
    if (Get.isRegistered<VehicleDetailsController>()) {
      final details = Get.find<VehicleDetailsController>().details.value;
      final typeIndex = vehicleList.indexWhere(
        (v) => v["name"] == details.vehicleType,
      );
      if (typeIndex != -1) vehicleType.value = typeIndex;
      vehicleNumberController.text = details.vehicleNumber;
      brandController.text = details.brand;
      modelController.text = details.model;
      colorController.text = details.color;
      yearController.text = details.yearOfManufacture;
      rcNumberController.text = details.rcNumber;
      registrationDateController.text = details.registrationDate;
      insuranceValidityController.text = details.insuranceValidity;
      pucValidityController.text = details.pucValidity;
    }
  }

  Future<void> pickYear(BuildContext context) async {
    final now = DateTime.now();
    final initialYear = int.tryParse(yearController.text) ?? now.year;
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(initialYear),
      firstDate: DateTime(1990),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) yearController.text = "${picked.year}";
  }

  Future<void> pickDate(
    BuildContext context,
    TextEditingController controller, {
    bool allowFuture = false,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1990),
      lastDate: allowFuture ? DateTime(now.year + 30) : now,
    );
    if (picked != null) {
      controller.text =
          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
    }
  }

  void onUpdate(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (vehicleNumberController.text.trim().isEmpty) {
      showErrorSnackBar(
        "Please enter your vehicle registration number",
        context,
      );
      return;
    }
    // TODO: send the updated vehicle details to api.
    if (Get.isRegistered<VehicleDetailsController>()) {
      Get.find<VehicleDetailsController>().details.value = VehicleDetails(
        vehicleType: vehicleList[vehicleType.value]["name"]!,
        vehicleNumber: vehicleNumberController.text.trim(),
        brand: brandController.text.trim(),
        model: modelController.text.trim(),
        color: colorController.text.trim(),
        yearOfManufacture: yearController.text.trim(),
        rcNumber: rcNumberController.text.trim(),
        registrationDate: registrationDateController.text.trim(),
        insuranceValidity: insuranceValidityController.text.trim(),
        pucValidity: pucValidityController.text.trim(),
      );
    }
    Get.back();
    showSuccessSnackBar("Vehicle details updated successfully", context);
  }

  @override
  void onClose() {
    vehicleNumberController.dispose();
    brandController.dispose();
    modelController.dispose();
    colorController.dispose();
    yearController.dispose();
    rcNumberController.dispose();
    registrationDateController.dispose();
    insuranceValidityController.dispose();
    pucValidityController.dispose();
    super.onClose();
  }
}
