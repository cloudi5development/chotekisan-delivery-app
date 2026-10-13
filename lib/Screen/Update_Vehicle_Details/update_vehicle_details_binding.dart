import 'package:chotekisan_delivery_app/Screen/Update_Vehicle_Details/update_vehicle_details_controller.dart';
import 'package:get/get.dart';

class UpdateVehicleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UpdateVehicleDetailsController>(UpdateVehicleDetailsController());
  }
}
