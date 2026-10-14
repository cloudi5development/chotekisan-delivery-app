import 'package:chotekisan_delivery_app/Screen/Wallet/wallet_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        body: Column(
          children: [
            CustomAppHeader(
              title: 'My Wallet',
              showBack: true,
              showSupport: true,
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
                    // ── Wallet card (stacked pocket design) ────────────────
                    _WalletCard(controller: controller, width: width),

                    const SizedBox(height: 20),

                    // ── Wallet summary ─────────────────────────────────────
                    _WalletSummary(controller: controller, myColors: myColors),

                    const SizedBox(height: 24),

                    // ── Manage Wallet ──────────────────────────────────────
                    OnestText(
                      text: 'Manage Wallet',
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize20(context),
                      fontWeight: FontWeight.w700,
                    ),

                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xffE5E7EB)),
                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => _ManageWalletTile(
                              title: controller.isWalletStyle2.value
                                  ? 'Bank Account'
                                  : 'Manage Bank Account',
                              subtitle:
                                  '${controller.bankName} ${controller.bankAccountMasked}',
                              onTap: controller.onManageBankAccount,
                            ),
                          ),
                          const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xffE5E7EB),
                          ),
                          _ManageWalletTile(
                            title: 'Payout History',
                            subtitle: 'View all payouts',
                            onTap: controller.onPayoutHistory,
                          ),
                          const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xffE5E7EB),
                          ),
                          _ManageWalletTile(
                            title: "FAQ's",
                            subtitle: 'Get help with payout & withdrawals',
                            onTap: controller.onFaqs,
                          ),
                        ],
                      ),
                    ),
                  ],
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
// Wallet card widget — stacked pocket design with notch
// ─────────────────────────────────────────────────────────────────────────────

class _WalletCard extends StatelessWidget {
  const _WalletCard({required this.controller, required this.width});

  final WalletController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: controller.toggleWalletStyle,
      child: Obx(() {
        if (controller.isWalletStyle2.value) {
          return _WalletCardStyle2(controller: controller);
        }
        return _WalletCardStyle1(controller: controller);
      }),
    );
  }
}

/// Style 1: Gold Pocket Card with green button (matches wallet_1.webp)
class _WalletCardStyle1 extends StatelessWidget {
  const _WalletCardStyle1({required this.controller});

  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1312 / 1024,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetImagePath.wallet1,
              fit: BoxFit.fill,
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final h = constraints.maxHeight;
              return Stack(
                children: [
                  // ── Top tab: Order Earnings & amount ─────────────
                  Positioned(
                    top: h * 0.075,
                    left: 36,
                    right: 36,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OnestText(
                          text: 'Order Earnings',
                          color: Colors.white,
                          fontSize: ResponsiveFontSizes.fontSize17(context),
                          fontWeight: FontWeight.w600,
                        ),
                        Obx(
                          () => OnestText(
                            text:
                                '₹${_fmt(controller.orderEarnings.value.toInt())}',
                            color: Colors.white,
                            fontSize: ResponsiveFontSizes.fontSize20(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Pocket: Total Balance & INR ──────────────────
                  Positioned(
                    top: h * 0.28,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnestText(
                          text: 'Total Balance',
                          color: const Color(0xff4B5563),
                          fontSize: ResponsiveFontSizes.fontSize13(context),
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 2),
                        Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              OnestText(
                                text:
                                    '₹${_fmt(controller.totalBalance.value.toInt())}',
                                color: const Color(0xff111827),
                                fontSize:
                                    ResponsiveFontSizes.fontSize55(context),
                                fontWeight: FontWeight.w700,
                                lineHeight: 1.1,
                              ),
                              const SizedBox(width: 6),
                              OnestText(
                                text: 'INR',
                                color: const Color(0xff6B7280),
                                fontSize:
                                    ResponsiveFontSizes.fontSize15(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Withdraw Money button ────────────────────────
                  Positioned(
                    bottom: h * 0.10,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.withdrawMoney),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xff066006),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff066006)
                                  .withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OnestText(
                              text: 'Withdraw Money',
                              color: Colors.white,
                              fontSize: ResponsiveFontSizes.fontSize17(context),
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Style 2: Brown Leather Pocket Card with translucent button (matches wallet_2.webp)
class _WalletCardStyle2 extends StatelessWidget {
  const _WalletCardStyle2({required this.controller});

  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1312 / 888,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetImagePath.wallet2,
              fit: BoxFit.fill,
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final h = constraints.maxHeight;
              return Stack(
                children: [
                  // ── Top tab: Order Earnings + date subtitle + amount ──
                  Positioned(
                    top: h * 0.15,
                    left: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OnestText(
                              text: 'Order Earnings',
                              color: Colors.white,
                              fontSize: ResponsiveFontSizes.fontSize17(context),
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 2),
                            OnestText(
                              text: controller.orderEarningsPeriod,
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: ResponsiveFontSizes.fontSize12(context),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Obx(
                          () => OnestText(
                            text:
                                '₹${_fmt(controller.orderEarnings.value.toInt())}',
                            color: Colors.white,
                            fontSize: ResponsiveFontSizes.fontSize22(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Brown pocket: Total Balance & Amount ─────────
                  Positioned(
                    top: h * 0.44,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnestText(
                          text: 'Total Balance',
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: ResponsiveFontSizes.fontSize13(context),
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 2),
                        Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              OnestText(
                                text:
                                    '₹${_fmt(controller.totalBalance.value.toInt())}',
                                color: Colors.white,
                                fontSize:
                                    ResponsiveFontSizes.fontSize55(context),
                                fontWeight: FontWeight.w700,
                                lineHeight: 1.1,
                              ),
                              const SizedBox(width: 6),
                              OnestText(
                                text: 'INR',
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize:
                                    ResponsiveFontSizes.fontSize15(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Withdraw Money button (translucent outline) ──
                  Positioned(
                    bottom: h * 0.10,
                    left: 14,
                    right: 14,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.withdrawMoney),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.55),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OnestText(
                              text: 'Withdraw Money',
                              color: Colors.white,
                              fontSize: ResponsiveFontSizes.fontSize17(context),
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Wallet Summary widget
// ─────────────────────────────────────────────────────────────────────────────

class _WalletSummary extends StatelessWidget {
  const _WalletSummary({required this.controller, required this.myColors});

  final WalletController controller;
  final MyColors? myColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          OnestText(
            text: 'WALLET SUMMARY',
            color: myColors?.txt,
            fontSize: ResponsiveFontSizes.fontSize13(context),
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    OnestText(
                      text: 'Total Earnings',
                      color: const Color(0xff6B7280),
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => OnestText(
                        text:
                            '₹${_fmt(controller.totalEarnings.value.toInt())}',
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize22(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 44, color: const Color(0xffE5E7EB)),
              Expanded(
                child: Column(
                  children: [
                    OnestText(
                      text: 'Total Withdrawn',
                      color: const Color(0xff6B7280),
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => OnestText(
                        text:
                            '₹${_fmt(controller.totalWithdrawn.value.toInt())}',
                        color: const Color(0xff066006),
                        fontSize: ResponsiveFontSizes.fontSize22(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Manage Wallet tile
// ─────────────────────────────────────────────────────────────────────────────

class _ManageWalletTile extends StatelessWidget {
  const _ManageWalletTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OnestText(
                    text: title,
                    color: myColors?.txt,
                    fontSize: ResponsiveFontSizes.fontSize17(context),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 3),
                  OnestText(
                    text: subtitle,
                    color: const Color(0xff6B7280),
                    fontSize: ResponsiveFontSizes.fontSize15(context),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 22,
              color: Color(0xff6B7280),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers & Custom Painters for pocket envelope design
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

