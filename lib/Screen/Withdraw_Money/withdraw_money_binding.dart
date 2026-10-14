import 'package:chotekisan_delivery_app/Screen/Withdraw_Money/withdraw_money_controller.dart';
import 'package:get/get.dart';

class WithdrawMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WithdrawMoneyController>(WithdrawMoneyController());
  }
}

