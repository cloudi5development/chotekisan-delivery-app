import 'package:chotekisan_delivery_app/Screen/Manage_Bank_Account/manage_bank_account_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ManageBankAccountScreen extends GetView<ManageBankAccountController> {
  const ManageBankAccountScreen({super.key});

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
              title: 'Manage Bank Account',
              showBack: true,
              showSupport: false,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  20 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Add Bank Account tile ──────────────────────────
                    GestureDetector(
                      onTap: controller.onAddBankAccount,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xffE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xffEEF8F0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Icon(
                                    Icons.account_balance,
                                    color: Color(0xff066006),
                                    size: 24,
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(1.5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xff066006),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 9,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OnestText(
                                    text: 'Add Bank Account',
                                    color: myColors?.txt,
                                    fontSize:
                                        ResponsiveFontSizes.fontSize18(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  OnestText(
                                    text: 'You can change at any time.',
                                    color: const Color(0xff6B7280),
                                    fontSize:
                                        ResponsiveFontSizes.fontSize15(context),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Saved Accounts ─────────────────────────────────
                    OnestText(
                      text: 'Saved Accounts',
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize20(context),
                      fontWeight: FontWeight.w700,
                    ),

                    const SizedBox(height: 12),

                    Obx(
                      () => Column(
                        children: controller.accounts.map((account) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _BankAccountCard(
                              account: account,
                              myColors: myColors,
                              onTap: () => controller.toggleExpand(account),
                              onSelect: () => controller.selectAccount(account),
                            ),
                          );
                        }).toList(),
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
// Bank Account Card — collapsible
// ─────────────────────────────────────────────────────────────────────────────

class _BankAccountCard extends StatelessWidget {
  const _BankAccountCard({
    required this.account,
    required this.myColors,
    required this.onTap,
    required this.onSelect,
  });

  final BankAccountModel account;
  final MyColors? myColors;
  final VoidCallback onTap;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xffE5E7EB)),
        ),
        child: Column(
          children: [
            // ── Header row ───────────────────────────────────────────
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    // Radio button
                    GestureDetector(
                      onTap: onSelect,
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: account.isPrimary.value
                                ? const Color(0xff066006)
                                : const Color(0xffD1D5DB),
                            width: 2,
                          ),
                        ),
                        child: account.isPrimary.value
                            ? Center(
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff066006),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Bank logo
                    _BankLogo(bankName: account.bankName),
                    const SizedBox(width: 10),

                    // Bank name + account number
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OnestText(
                            text: account.bankName,
                            color: myColors?.txt,
                            fontSize: ResponsiveFontSizes.fontSize17(context),
                            fontWeight: FontWeight.w600,
                          ),
                          OnestText(
                            text: account.accountMasked,
                            color: const Color(0xff6B7280),
                            fontSize: ResponsiveFontSizes.fontSize15(context),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),

                    // Primary badge
                    if (account.isPrimary.value) ...[
                      OnestText(
                        text: 'Primary',
                        color: const Color(0xff066006),
                        fontSize: ResponsiveFontSizes.fontSize15(context),
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(width: 6),
                    ],

                    // Expand/collapse chevron
                    Icon(
                      account.isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: const Color(0xff6B7280),
                    ),
                  ],
                ),
              ),
            ),

            // ── Expanded details ─────────────────────────────────────
            if (account.isExpanded.value) ...[
              const Divider(height: 1, color: Color(0xffE5E7EB)),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ReadonlyField(
                      label: 'Bank Name',
                      value: account.bankName,
                      myColors: myColors,
                    ),
                    const SizedBox(height: 12),
                    _ReadonlyField(
                      label: 'Account Holder Name',
                      value: account.holderName,
                      myColors: myColors,
                    ),
                    const SizedBox(height: 12),
                    _ReadonlyField(
                      label: 'Bank Account Number',
                      value: account.accountNumber,
                      myColors: myColors,
                    ),
                    const SizedBox(height: 12),
                    _ReadonlyField(
                      label: 'IFSC Code',
                      value: account.ifscCode,
                      myColors: myColors,
                    ),
                    const SizedBox(height: 14),

                    // Set as Primary checkbox (read-only display in expanded)
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: account.isPrimary.value
                                ? const Color(0xff066006)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: account.isPrimary.value
                                  ? const Color(0xff066006)
                                  : const Color(0xffD1D5DB),
                              width: 1.5,
                            ),
                          ),
                          child: account.isPrimary.value
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
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
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Readonly field (label + value in a bordered box)
// ─────────────────────────────────────────────────────────────────────────────

class _ReadonlyField extends StatelessWidget {
  const _ReadonlyField({
    required this.label,
    required this.value,
    required this.myColors,
  });

  final String label;
  final String value;
  final MyColors? myColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnestText(
          text: label,
          color: const Color(0xff6B7280),
          fontSize: ResponsiveFontSizes.fontSize15(context),
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffE5E7EB)),
          ),
          alignment: Alignment.centerLeft,
          child: OnestText(
            text: value,
            color: myColors?.txt,
            fontSize: ResponsiveFontSizes.fontSize17(context),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bank logo placeholder — coloured initials
// ─────────────────────────────────────────────────────────────────────────────

class _BankLogo extends StatelessWidget {
  const _BankLogo({required this.bankName});

  final String bankName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE5E7EB)),
      ),
      alignment: Alignment.center,
      child: _buildLogo(),
    );
  }

  Widget _buildLogo() {
    if (bankName.contains('HDFC')) {
      return SizedBox(
        width: 22,
        height: 22,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffED1C24), width: 3.5),
              ),
            ),
            Container(width: 4, height: 22, color: Colors.white),
            Container(width: 22, height: 4, color: Colors.white),
            Container(width: 8, height: 8, color: const Color(0xff004B8D)),
          ],
        ),
      );
    } else if (bankName.contains('ICICI')) {
      return Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          color: Color(0xff9E1B32),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Text(
          'i',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 14,
            height: 1.1,
          ),
        ),
      );
    } else if (bankName.contains('Axis')) {
      return CustomPaint(
        size: const Size(20, 20),
        painter: _AxisLogoPainter(),
      );
    }

    return Text(
      bankName.isNotEmpty ? bankName[0] : 'B',
      style: const TextStyle(
        color: Color(0xff374151),
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}

class _AxisLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff97144D)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.6, size.height);
    path.lineTo(size.width * 0.5, size.height * 0.4);
    path.lineTo(size.width * 0.4, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

