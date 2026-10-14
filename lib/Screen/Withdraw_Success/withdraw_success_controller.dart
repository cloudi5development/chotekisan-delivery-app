import 'package:get/get.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';

class WithdrawSuccessController extends GetxController {
  // Data received from WithdrawMoneyScreen via Get.arguments
  late final double amount;
  late final String bankName;
  late final String accountMasked;
  late final String refId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    amount = (args['amount'] as double?) ?? 0;
    bankName = (args['bankName'] as String?) ?? 'HDFC Bank';
    accountMasked = (args['accountMasked'] as String?) ?? '****** 1234';
    refId = (args['refId'] as String?) ?? 'WID34156798301232';
  }

  void onBackToWallet() {
    Get.until((route) => route.settings.name == AppRoutes.wallet);
  }
}

