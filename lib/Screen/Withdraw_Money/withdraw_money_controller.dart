import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';

class WithdrawMoneyController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final RxDouble withdrawAmount = 0.0.obs;

  // Fee constants (TODO: load from API)
  final double withdrawalFee = 149;
  final double codSettlement = 149;

  // Bank details (TODO: load from API / shared prefs)
  final String bankName = 'HDFC Bank';
  final String bankAccountMasked = '****** 1234';

  // Available balance passed from wallet screen
  RxDouble availableBalance = 24679.0.obs;

  double get youWillReceive {
    final amount = withdrawAmount.value;
    if (amount <= 0) return 0;
    return (amount - withdrawalFee - codSettlement).clamp(0, double.infinity);
  }

  void onAmountChanged(String value) {
    withdrawAmount.value = double.tryParse(value) ?? 0;
  }

  void onChangeAccount() {
    Get.toNamed(AppRoutes.manageBankAccount);
  }

  void onConfirmWithdraw() {
    if (withdrawAmount.value <= 0) return;
    Get.toNamed(
      AppRoutes.withdrawSuccess,
      arguments: {
        'amount': withdrawAmount.value,
        'bankName': bankName,
        'accountMasked': bankAccountMasked,
        'refId': 'WID34156798301232',
      },
    );
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}

