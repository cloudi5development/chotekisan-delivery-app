import 'package:get/get.dart';

class VehicleDetails {
  String vehicleType;
  String vehicleNumber;
  String brand;
  String model;
  String color;
  String yearOfManufacture;
  String rcNumber;
  String registrationDate;
  String insuranceValidity;
  String pucValidity;

  VehicleDetails({
    this.vehicleType = "",
    this.vehicleNumber = "",
    this.brand = "",
    this.model = "",
    this.color = "",
    this.yearOfManufacture = "",
    this.rcNumber = "",
    this.registrationDate = "",
    this.insuranceValidity = "",
    this.pucValidity = "",
  });
}

class VehicleDetailsController extends GetxController {
  final Rx<VehicleDetails> details = VehicleDetails().obs;

  /// Whether any overview field is still missing.
  bool get isIncomplete =>
      details.value.brand.isEmpty ||
      details.value.model.isEmpty ||
      details.value.color.isEmpty ||
      details.value.yearOfManufacture.isEmpty ||
      details.value.rcNumber.isEmpty ||
      details.value.registrationDate.isEmpty ||
      details.value.insuranceValidity.isEmpty ||
      details.value.pucValidity.isEmpty;

  @override
  void onInit() {
    super.onInit();
    // Sample data. TODO: load the saved vehicle details from api.
    details.value = VehicleDetails(
      vehicleType: "Scooter",
      vehicleNumber: "TN 99 XX 0000",
      brand: "Honda",
      model: "Activa 6G",
      color: "Black",
      yearOfManufacture: "2022",
      rcNumber: "TN37AB12342022",
      registrationDate: "15 Mar 2022",
      insuranceValidity: "14 Mar 2032",
      pucValidity: "13 Jun 2026",
    );
  }
}
