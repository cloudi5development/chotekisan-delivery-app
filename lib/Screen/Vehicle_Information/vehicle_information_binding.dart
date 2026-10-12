import 'package:chotekisan_delivery_app/Screen/Vehicle_Information/vehicle_information_controller.dart';
import 'package:get/get.dart';

class VehicleInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VehicleInformationController>(VehicleInformationController());
  }
}
