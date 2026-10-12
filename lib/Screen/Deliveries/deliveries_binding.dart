import 'package:chotekisan_delivery_app/Screen/Deliveries/deliveries_controller.dart';
import 'package:get/get.dart';

class DeliveriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveriesController>(DeliveriesController());
  }
}
