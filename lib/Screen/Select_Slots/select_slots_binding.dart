import 'package:chotekisan_delivery_app/Screen/Select_Slots/select_slots_controller.dart';
import 'package:get/get.dart';

class SelectSlotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SelectSlotsController>(SelectSlotsController());
  }
}
