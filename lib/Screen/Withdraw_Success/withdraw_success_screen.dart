import 'package:chotekisan_delivery_app/Screen/Withdraw_Success/withdraw_success_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WithdrawSuccessScreen extends GetView<WithdrawSuccessController> {
  const WithdrawSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        body: SafeArea(
          child: Column(
            children: [
              // ── Main content ───────────────────────────────────────────
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── Wallet icon with signal arcs (asset image) ─────
                        Image.asset(
                          AssetImagePath.withdrawWallet,
                          height: 180,
                          width: 180,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 32),

                        // ── Status text ────────────────────────────────────
                        OnestText(
                          text: 'Your withdrawal is being processed',
                          color: const Color(0xff374151),
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 10),

                        // ── Amount ────────────────────────────────────────
                        OnestText(
                          text: '₹${controller.amount.toStringAsFixed(2)}',
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize55(context),
                          fontWeight: FontWeight.w700,
                          lineHeight: 1.2,
                        ),

                        const SizedBox(height: 16),

                        // ── To label ──────────────────────────────────────
                        OnestText(
                          text: 'To',
                          color: const Color(0xff9CA3AF),
                          fontSize: ResponsiveFontSizes.fontSize16(context),
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 4),

                        // ── Bank name ─────────────────────────────────────
                        OnestText(
                          text: '${controller.bankName} **** 1234',
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize22(context),
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 4),

                        // ── Ref ID ────────────────────────────────────────
                        OnestText(
                          text: 'Ref ID: ${controller.refId}',
                          color: const Color(0xff9CA3AF),
                          fontSize: ResponsiveFontSizes.fontSize15(context),
                          fontWeight: FontWeight.w400,
                        ),

                        const SizedBox(height: 28),

                        // ── 24-hour notice banner ─────────────────────────
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
                                      fontSize:
                                          ResponsiveFontSizes.fontSize16(context),
                                      height: 1.45,
                                    ),
                                    children: const [
                                      TextSpan(text: 'This may take up to '),
                                      TextSpan(
                                        text: '24 hours',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                          text: ' to reflect in your account.'),
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
              ),

              // ── Back to Wallet button ──────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  16 + MediaQuery.paddingOf(context).bottom,
                ),
                child: GestureDetector(
                  onTap: controller.onBackToWallet,
                  child: Container(
                    height: 52,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffECFDF5),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xff066006)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Color(0xff066006),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        OnestText(
                          text: 'Back to Wallet',
                          color: const Color(0xff066006),
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
