import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chotekisan_delivery_app/common/add_bank_account_sheet.dart';

/// A saved bank account entry
class BankAccountModel {
  final String bankName;
  final String accountMasked;
  final String holderName;
  final String accountNumber;
  final String ifscCode;
  RxBool isPrimary;
  RxBool isExpanded;

  BankAccountModel({
    required this.bankName,
    required this.accountMasked,
    required this.holderName,
    required this.accountNumber,
    required this.ifscCode,
    bool isPrimary = false,
    bool isExpanded = false,
  })  : isPrimary = isPrimary.obs,
        isExpanded = isExpanded.obs;
}

class ManageBankAccountController extends GetxController {
  // ── Saved accounts (sample data — TODO: load from API) ──────────────────
  final RxList<BankAccountModel> accounts = <BankAccountModel>[
    BankAccountModel(
      bankName: 'HDFC Bank',
      accountMasked: '******* 1234',
      holderName: 'Holder X',
      accountNumber: 'HDFC357E18261G89',
      ifscCode: '1082DQWUDNW',
      isPrimary: true,
      isExpanded: true,
    ),
    BankAccountModel(
      bankName: 'ICICI Bank',
      accountMasked: '******* 1234',
      holderName: 'Holder X',
      accountNumber: 'ICICI357E18261G89',
      ifscCode: '1082DQWUDNW',
    ),
    BankAccountModel(
      bankName: 'Axis Bank',
      accountMasked: '******* 1234',
      holderName: 'Holder X',
      accountNumber: 'AXIS357E18261G89',
      ifscCode: '1082DQWUDNW',
    ),
  ].obs;

  // ── Add Bank Account sheet fields ─────────────────────────────────────────
  final TextEditingController addBankNameCtrl = TextEditingController();
  final TextEditingController addHolderNameCtrl = TextEditingController();
  final TextEditingController addAccountNumberCtrl = TextEditingController();
  final TextEditingController addIfscCtrl = TextEditingController();
  final RxBool addSetAsPrimary = false.obs;
  final RxBool canAddBank = false.obs;

  @override
  void onInit() {
    super.onInit();
    addBankNameCtrl.addListener(_validateForm);
    addHolderNameCtrl.addListener(_validateForm);
    addAccountNumberCtrl.addListener(_validateForm);
    addIfscCtrl.addListener(_validateForm);
  }

  void _validateForm() {
    canAddBank.value =
        addBankNameCtrl.text.trim().isNotEmpty &&
        addHolderNameCtrl.text.trim().isNotEmpty &&
        addAccountNumberCtrl.text.trim().isNotEmpty &&
        addIfscCtrl.text.trim().length >= 4;
  }

  void toggleAddSetAsPrimary() {
    addSetAsPrimary.value = !addSetAsPrimary.value;
  }

  void onAddBankAccount() {
    _clearAddFields();
    Get.bottomSheet(
      const AddBankAccountSheet(),
      isScrollControlled: true,
    );
  }

  void onAddBank() {
    final newAccount = BankAccountModel(
      bankName: addBankNameCtrl.text.trim(),
      accountMasked: '******* ${addAccountNumberCtrl.text.trim().length >= 4 ? addAccountNumberCtrl.text.trim().substring(addAccountNumberCtrl.text.trim().length - 4) : '****'}',
      holderName: addHolderNameCtrl.text.trim(),
      accountNumber: addAccountNumberCtrl.text.trim(),
      ifscCode: addIfscCtrl.text.trim().toUpperCase(),
      isPrimary: addSetAsPrimary.value,
    );
    if (addSetAsPrimary.value) {
      for (final a in accounts) {
        a.isPrimary.value = false;
      }
    }
    accounts.add(newAccount);
    _clearAddFields();
    Get.back();
  }

  void _clearAddFields() {
    addBankNameCtrl.clear();
    addHolderNameCtrl.clear();
    addAccountNumberCtrl.clear();
    addIfscCtrl.clear();
    addSetAsPrimary.value = false;
  }

  void toggleExpand(BankAccountModel account) {
    account.isExpanded.value = !account.isExpanded.value;
  }

  void selectAccount(BankAccountModel account) {
    for (final a in accounts) {
      a.isPrimary.value = false;
    }
    account.isPrimary.value = true;
  }

  @override
  void onClose() {
    addBankNameCtrl.dispose();
    addHolderNameCtrl.dispose();
    addAccountNumberCtrl.dispose();
    addIfscCtrl.dispose();
    super.onClose();
  }
}

