import 'package:chotekisan_delivery_app/Screen/Withdraw_Money/withdraw_money_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WithdrawMoneyScreen extends GetView<WithdrawMoneyController> {
  const WithdrawMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        body: Column(
          children: [
            CustomAppHeader(
              title: 'Withdraw Money',
              showBack: true,
              showSupport: false,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  20,
                  16,
                  20 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Available balance ──────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OnestText(
                            text: 'Available Balance',
                            color: const Color(0xff6B7280),
                            fontSize: ResponsiveFontSizes.fontSize18(context),
                            fontWeight: FontWeight.w400,
                          ),
                          Obx(
                            () => OnestText(
                              text: '₹${_fmt(controller.availableBalance.value.toInt())}',
                              color: const Color(0xff066006),
                              fontSize: ResponsiveFontSizes.fontSize22(context),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Enter Amount ───────────────────────────────────────
                    Center(
                      child: OnestText(
                        text: 'Enter Amount',
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize20(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          OnestText(
                            text: '₹',
                            color: const Color(0xffBBBBBB),
                            fontSize: ResponsiveFontSizes.fontSize20(context),
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller.amountController,
                              keyboardType: const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}'),
                                ),
                              ],
                              onChanged: controller.onAmountChanged,
                              style: TextStyle(
                                fontSize: ResponsiveFontSizes.fontSize18(context),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff222222),
                              ),
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: const Color(0xffBBBBBB),
                                  fontSize: ResponsiveFontSizes.fontSize18(context),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Withdrawal To ──────────────────────────────────────
                    OnestText(
                      text: 'Withdrawal To',
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize20(context),
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          // HDFC logo placeholder
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xffE5E7EB)),
                            ),
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffED1C24),
                                        width: 3.5,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 22,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 22,
                                    height: 4,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    color: const Color(0xff004B8D),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OnestText(
                                  text: controller.bankName,
                                  color: myColors?.txt,
                                  fontSize: ResponsiveFontSizes.fontSize18(context),
                                  fontWeight: FontWeight.w600,
                                ),
                                OnestText(
                                  text: controller.bankAccountMasked,
                                  color: const Color(0xff6B7280),
                                  fontSize: ResponsiveFontSizes.fontSize16(context),
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.onChangeAccount,
                            child: OnestText(
                              text: 'Change Account?',
                              color: const Color(0xff066006),
                              fontSize: ResponsiveFontSizes.fontSize16(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Withdrawal Breakdown ───────────────────────────────
                    OnestText(
                      text: 'Withdrawal Breakdown',
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize20(context),
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => _BreakdownRow(
                              label: 'Withdrawal Amount',
                              value: '₹${controller.withdrawAmount.value.toStringAsFixed(0)}',
                              myColors: myColors,
                              context: context,
                            ),
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xffE5E7EB)),
                          _BreakdownRow(
                            label: 'Withdrawal Fee',
                            value: '-₹${controller.withdrawalFee.toInt()}',
                            myColors: myColors,
                            context: context,
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xffE5E7EB)),
                          _BreakdownRow(
                            label: 'COD Settlement',
                            value: '-₹${controller.codSettlement.toInt()}',
                            myColors: myColors,
                            context: context,
                          ),
                          const Divider(height: 1, color: Color(0xffE5E7EB)),
                          Obx(
                            () => _BreakdownRow(
                              label: 'You Will Receive',
                              value: '₹${controller.youWillReceive.toStringAsFixed(0)}',
                              myColors: myColors,
                              isBold: true,
                              context: context,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── 24-hour notice banner ──────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF3E0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xffF59E0B),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: const Color(0xff92400E),
                                  fontSize: ResponsiveFontSizes.fontSize16(context),
                                  height: 1.45,
                                ),
                                children: const [
                                  TextSpan(
                                    text: 'Money will be transferred to your bank account within ',
                                  ),
                                  TextSpan(
                                    text: '24 hours.',
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Confirm Withdraw button ────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                12,
                16,
                16 + MediaQuery.paddingOf(context).bottom,
              ),
              child: GestureDetector(
                onTap: controller.onConfirmWithdraw,
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff066006),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: OnestText(
                    text: 'Confirm Withdraw',
                    color: Colors.white,
                    fontSize: ResponsiveFontSizes.fontSize18(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Breakdown row helper widget
// ─────────────────────────────────────────────────────────────────────────────

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.value,
    required this.myColors,
    required this.context,
    this.isBold = false,
  });

  final String label;
  final String value;
  final MyColors? myColors;
  final bool isBold;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OnestText(
            text: label,
            color: isBold ? myColors?.txt : const Color(0xff6B7280),
            fontSize: ResponsiveFontSizes.fontSize18(context),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
          OnestText(
            text: value,
            color: myColors?.txt,
            fontSize: ResponsiveFontSizes.fontSize18(context),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

String _fmt(int value) {
  final str = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) buf.write(',');
    buf.write(str[i]);
  }
  return buf.toString();
}

