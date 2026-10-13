import 'package:chotekisan_delivery_app/Screen/Delivery_Closed/delivery_closed_controller.dart';
import 'package:get/get.dart';

class DeliveryClosedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryClosedController>(DeliveryClosedController());
  }
}
