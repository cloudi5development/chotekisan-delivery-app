import 'package:chotekisan_delivery_app/Screen/Vehicle_Details/vehicle_details_controller.dart';
import 'package:get/get.dart';

class VehicleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VehicleDetailsController>(VehicleDetailsController());
  }
}
