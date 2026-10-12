import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_controller.dart';
import 'package:chotekisan_delivery_app/Screen/Deliveries/deliveries_controller.dart';
import 'package:chotekisan_delivery_app/Screen/Home/home_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
    // Home is the first tab of the dashboard, so its controller is created
    // alongside it.
    Get.put<HomeController>(HomeController());
    // Deliveries is the second tab, rendered inside the same IndexedStack. It
    // reads its orders from HomeController, so it is created after it.
    Get.put<DeliveriesController>(DeliveriesController());
  }
}
