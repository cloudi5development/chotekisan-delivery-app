import 'package:chotekisan_delivery_app/Screen/Delivery_Person_Type/delivery_person_type_controller.dart';
import 'package:get/get.dart';

class DeliveryPersonTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryPersonTypeController>(DeliveryPersonTypeController());
  }
}
