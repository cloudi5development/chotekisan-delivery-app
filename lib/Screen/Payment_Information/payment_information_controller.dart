import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentInformationController extends GetxController {
  // 0 = Bank Account, 1 = UPI
  RxInt paymentMethod = 0.obs;
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController upiController = TextEditingController();

  String? _validate() {
    if (paymentMethod.value == 1) {
      if (upiController.text.trim().isEmpty) return "Please enter your UPI ID";
      return null;
    }
    if (bankNameController.text.trim().isEmpty) {
      return "Please enter your bank name";
    }
    if (accountHolderController.text.trim().isEmpty) {
      return "Please enter the account holder name";
    }
    if (accountNumberController.text.trim().isEmpty) {
      return "Please enter your bank account number";
    }
    if (ifscController.text.trim().length != 11) {
      return "Please enter a valid 11 character IFSC code";
    }
    return null;
  }

  void onNext(BuildContext context) {
    FocusScope.of(context).unfocus();
    final error = _validate();
    if (error != null) {
      showErrorSnackBar(error, context);
      return;
    }
    Get.toNamed(AppRoutes.declaration);
  }

  void onBack() {
    Get.back();
  }

  @override
  void onClose() {
    bankNameController.dispose();
    accountHolderController.dispose();
    accountNumberController.dispose();
    ifscController.dispose();
    upiController.dispose();
    super.onClose();
  }
}
