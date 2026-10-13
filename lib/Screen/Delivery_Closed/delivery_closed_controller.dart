import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class DeliveryClosedController extends GetxController {
  late final OrderModel order;

  @override
  void onInit() {
    super.onInit();
    order = Get.arguments as OrderModel;
  }

  void onBackToHome() {
    // The dashboard is still underneath, so pop back to it on the Home tab
    Get.find<DashboardController>().changeTabIndex(0);
    Get.back();
  }
}
