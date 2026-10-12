import 'package:chotekisan_delivery_app/Screen/Delivery_Details/delivery_details_controller.dart';
import 'package:get/get.dart';

class DeliveryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryDetailsController>(DeliveryDetailsController());
  }
}
