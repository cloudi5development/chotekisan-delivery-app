import 'package:chotekisan_delivery_app/Screen/Help_Support/help_support_controller.dart';
import 'package:get/get.dart';

class HelpSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HelpSupportController>(HelpSupportController());
  }
}
