import 'package:chotekisan_delivery_app/Screen/Refer_Earn/refer_earn_controller.dart';
import 'package:get/get.dart';

class ReferEarnBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReferEarnController>(ReferEarnController());
  }
}
