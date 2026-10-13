import 'package:chotekisan_delivery_app/Screen/Earnings/earnings_controller.dart';
import 'package:get/get.dart';

class EarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EarningsController>(EarningsController());
  }
}
