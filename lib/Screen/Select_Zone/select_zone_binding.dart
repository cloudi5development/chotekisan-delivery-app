import 'package:chotekisan_delivery_app/Screen/Select_Zone/select_zone_controller.dart';
import 'package:get/get.dart';

class SelectZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SelectZoneController>(SelectZoneController());
  }
}
