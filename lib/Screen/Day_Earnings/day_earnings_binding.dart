import 'package:chotekisan_delivery_app/Screen/Day_Earnings/day_earnings_controller.dart';
import 'package:get/get.dart';

class DayEarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DayEarningsController>(DayEarningsController());
  }
}
