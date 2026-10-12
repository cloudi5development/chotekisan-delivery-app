import 'package:chotekisan_delivery_app/Screen/Payment_Information/payment_information_controller.dart';
import 'package:get/get.dart';

class PaymentInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaymentInformationController>(PaymentInformationController());
  }
}
