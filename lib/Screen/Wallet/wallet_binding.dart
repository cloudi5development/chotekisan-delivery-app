import 'package:chotekisan_delivery_app/Screen/Wallet/wallet_controller.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WalletController>(WalletController());
  }
}

