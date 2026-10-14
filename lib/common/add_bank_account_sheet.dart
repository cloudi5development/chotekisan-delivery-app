import 'package:chotekisan_delivery_app/Screen/Manage_Bank_Account/manage_bank_account_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/custom_textfield.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Bottom sheet — Add Bank Account
class AddBankAccountSheet extends GetView<ManageBankAccountController> {
  const AddBankAccountSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();

    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ─────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: OnestText(
                        text: 'Add Bank Account',
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize20(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xffEDEDED),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xff4B5563),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ── Bank Name ──────────────────────────────────────────
                CustomLabelTextfield(
                  label: 'Bank Name',
                  hintText: 'Enter bank name',
                  isRequired: true,
                  textEditingController: controller.addBankNameCtrl,
                  textCapitalization: TextCapitalization.words,
                ),

                const SizedBox(height: 14),

                // ── Account Holder Name ────────────────────────────────
                CustomLabelTextfield(
                  label: 'Account Holder Name',
                  hintText: 'Enter acc holder name',
                  isRequired: true,
                  textEditingController: controller.addHolderNameCtrl,
                  textCapitalization: TextCapitalization.words,
                ),

                const SizedBox(height: 14),

                // ── Bank Account Number ────────────────────────────────
                CustomLabelTextfield(
                  label: 'Bank Account Number',
                  hintText: 'Enter acc number',
                  isRequired: true,
                  keyboardType: TextInputType.text,
                  textEditingController: controller.addAccountNumberCtrl,
                ),

                const SizedBox(height: 14),

                // ── IFSC Code ──────────────────────────────────────────
                CustomLabelTextfield(
                  label: 'IFSC Code',
                  hintText: 'Enter 11 character IFSC Code',
                  isRequired: true,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  ],
                  textEditingController: controller.addIfscCtrl,
                ),

                const SizedBox(height: 16),

                // ── Set as Primary checkbox ────────────────────────────
                GestureDetector(
                  onTap: controller.toggleAddSetAsPrimary,
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: controller.addSetAsPrimary.value
                              ? const Color(0xff066006)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: controller.addSetAsPrimary.value
                                ? const Color(0xff066006)
                                : const Color(0xffD1D5DB),
                            width: 1.5,
                          ),
                        ),
                        child: controller.addSetAsPrimary.value
                            ? const Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 10),
                      OnestText(
                        text: 'Set as Primary',
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize17(context),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Add Bank button ────────────────────────────────────
                CustomButton(
                  text: 'Add Bank',
                  height: 50,
                  width: width,
                  bgcolor: controller.canAddBank.value
                      ? const Color(0xff066006)
                      : const Color(0xffCBD5E1),
                  textcolor: controller.canAddBank.value
                      ? Colors.white
                      : const Color(0xff94A3B8),
                  borderRadius: 14,
                  onPressed: controller.canAddBank.value ? controller.onAddBank : null,
                ),

                const SizedBox(height: 12),

                // ── Cancel button ──────────────────────────────────────
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 50,
                    width: width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF8F0),
                      border: Border.all(color: const Color(0xffCFEAD6)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: OnestText(
                      text: 'Cancel',
                      color: const Color(0xff4B5563),
                      fontSize: ResponsiveFontSizes.fontSize18(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

