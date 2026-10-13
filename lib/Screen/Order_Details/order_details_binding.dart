import 'package:chotekisan_delivery_app/Screen/Order_Details/order_details_controller.dart';
import 'package:get/get.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderDetailsController>(OrderDetailsController());
  }
}
