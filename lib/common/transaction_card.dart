import 'package:chotekisan_delivery_app/Model/earning_model.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';

/// Grey card for one completed order on the Earnings screens.
class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  /// Text under the order id: just the time, or the date and time.
  final String timeText;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.timeText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          color: const Color(0xffF3F4F6),
          border: Border.all(color: const Color(0xffE5E7EB)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AssetImagePath.orderIcon,
                    height: 20,
                    width: 20,
                    color: const Color(0xff0FA53A),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OnestText(
                        text: transaction.orderId,
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize17(context),
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.4,
                      ),
                      OnestText(
                        text: timeText,
                        color: myColors?.primaryText,
                        fontSize: ResponsiveFontSizes.fontSize13(context),
                        fontWeight: FontWeight.w400,
                        lineHeight: 1.4,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OnestText(
                      text: "Earned",
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize13(context),
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.3,
                    ),
                    OnestText(
                      text: "₹${transaction.earned}",
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize24(context),
                      fontWeight: FontWeight.w700,
                      lineHeight: 1.3,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: OnestText(
                    text: "Cash Collected: ₹${transaction.cashCollected}",
                    color: myColors?.txt,
                    fontSize: ResponsiveFontSizes.fontSize15(context),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (transaction.tips > 0) ...[
                  OnestText(
                    text: "+₹${transaction.tips}",
                    color: myColors?.primary,
                    fontSize: ResponsiveFontSizes.fontSize15(context),
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(width: 6),
                ],
                Icon(Icons.arrow_forward_ios, size: 14, color: myColors?.txt),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
