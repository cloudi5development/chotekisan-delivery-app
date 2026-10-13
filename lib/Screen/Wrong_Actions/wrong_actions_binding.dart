import 'package:chotekisan_delivery_app/Screen/Wrong_Actions/wrong_actions_controller.dart';
import 'package:get/get.dart';

class WrongActionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WrongActionsController>(WrongActionsController());
  }
}
