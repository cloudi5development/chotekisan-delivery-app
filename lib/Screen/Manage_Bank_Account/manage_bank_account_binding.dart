import 'package:chotekisan_delivery_app/Screen/Manage_Bank_Account/manage_bank_account_controller.dart';
import 'package:get/get.dart';

class ManageBankAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ManageBankAccountController>(ManageBankAccountController());
  }
}

