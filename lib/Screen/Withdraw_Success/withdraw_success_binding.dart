import 'package:chotekisan_delivery_app/Screen/Withdraw_Success/withdraw_success_controller.dart';
import 'package:get/get.dart';

class WithdrawSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WithdrawSuccessController>(WithdrawSuccessController());
  }
}

