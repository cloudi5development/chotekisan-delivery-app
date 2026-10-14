import 'package:chotekisan_delivery_app/Screen/Payout_History/payout_history_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PayoutHistoryScreen extends GetView<PayoutHistoryController> {
  const PayoutHistoryScreen({super.key});

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
              title: 'Payout History',
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
                child: Obx(
                  () => Column(
                    children: [
                      // ── "Your Payouts" header row with filter icon ─────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OnestText(
                            text: 'Your Payouts',
                            color: myColors?.txt,
                            fontSize: ResponsiveFontSizes.fontSize20(context),
                            fontWeight: FontWeight.w700,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: controller.openFilter,
                            child: Icon(
                              Icons.filter_list,
                              size: 24,
                              color: controller.isFiltered.value
                                  ? const Color(0xff066006)
                                  : myColors?.txt,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ── Payout list ────────────────────────────────────
                      if (controller.payouts.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: OnestText(
                            text: 'No payouts found.',
                            color: myColors?.primaryText,
                            fontSize: ResponsiveFontSizes.fontSize17(context),
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xffE5E7EB),
                            ),
                          ),
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i < controller.payouts.length;
                                  i++) ...[
                                if (i != 0)
                                  const Divider(
                                    height: 1,
                                    indent: 14,
                                    endIndent: 14,
                                    color: Color(0xffF3F4F6),
                                  ),
                                _PayoutRow(
                                  payout: controller.payouts[i],
                                  myColors: myColors,
                                ),
                              ],
                            ],
                          ),
                        ),
                    ],
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
// Single payout row
// ─────────────────────────────────────────────────────────────────────────────

class _PayoutRow extends StatelessWidget {
  const _PayoutRow({required this.payout, required this.myColors});

  final PayoutModel payout;
  final MyColors? myColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: payout ID + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnestText(
                  text: payout.payoutId,
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize18(context),
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 3),
                OnestText(
                  text: payout.dateTimeText,
                  color: const Color(0xff6B7280),
                  fontSize: ResponsiveFontSizes.fontSize15(context),
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Right: amount + status badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OnestText(
                text: '₹${_fmt(payout.amount.toInt())}',
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize18(context),
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              _StatusBadge(status: payout.status),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status badge
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final PayoutStatus status;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color textColor;
    String label;

    switch (status) {
      case PayoutStatus.success:
        bg = const Color(0xffEEF8F0);
        textColor = const Color(0xff066006);
        label = 'Success';
        break;
      case PayoutStatus.processing:
        bg = const Color(0xffFFF7ED);
        textColor = const Color(0xffD97706);
        label = 'Processing';
        break;
      case PayoutStatus.rejected:
        bg = const Color(0xffFFF1F0);
        textColor = const Color(0xffDC2626);
        label = 'Rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: OnestText(
        text: label,
        color: textColor,
        fontSize: ResponsiveFontSizes.fontSize14(context),
        fontWeight: FontWeight.w500,
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

