import 'package:chotekisan_delivery_app/Screen/Faqs/faqs_controller.dart';
import 'package:get/get.dart';

class FaqsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FaqsController>(FaqsController());
  }
}
