import 'package:chotekisan_delivery_app/Screen/Declaration/declaration_controller.dart';
import 'package:get/get.dart';

class DeclarationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeclarationController>(DeclarationController());
  }
}
