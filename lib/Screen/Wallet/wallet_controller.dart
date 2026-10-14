import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';

class WalletController extends GetxController {
  // Wallet data
  final RxDouble totalBalance = 24679.0.obs;
  final RxDouble orderEarnings = 21236.0.obs;
  final RxDouble totalEarnings = 92589.0.obs;
  final RxDouble totalWithdrawn = 67910.0.obs;

  // Period label shown on the peek card
  final String orderEarningsPeriod = 'From 13 May To 15 Jun';

  // Toggle between wallet_1 (gold) and wallet_2 (brown/layered)
  final RxBool isWalletStyle2 = true.obs;

  void toggleWalletStyle() {
    isWalletStyle2.value = !isWalletStyle2.value;
  }

  // Bank info
  final String bankName = 'HDFC Bank';
  final String bankAccountMasked = '******1234';

  // Withdraw screen state
  final TextEditingController amountController = TextEditingController();
  final RxDouble withdrawAmount = 0.0.obs;
  final double withdrawalFee = 149;
  final double codSettlement = 149;

  double get youWillReceive {
    final amount = withdrawAmount.value;
    if (amount <= 0) return 0;
    return (amount - withdrawalFee - codSettlement).clamp(0, double.infinity);
  }

  void onAmountChanged(String value) {
    final parsed = double.tryParse(value) ?? 0;
    withdrawAmount.value = parsed;
  }

  void onWithdraw() {
    if (withdrawAmount.value <= 0) return;
    Get.toNamed(AppRoutes.withdrawSuccess, arguments: {
      'amount': withdrawAmount.value,
      'bankName': bankName,
      'accountMasked': bankAccountMasked,
      'refId': 'WID34156798301232',
    });
  }

  void onManageBankAccount() {
    Get.toNamed(AppRoutes.manageBankAccount);
  }

  void onPayoutHistory() {
    Get.toNamed(AppRoutes.payoutHistory);
  }

  void onFaqs() {
    Get.toNamed(AppRoutes.faqs);
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}

