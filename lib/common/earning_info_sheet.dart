import 'package:chotekisan_delivery_app/Model/earning_model.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';

/// "Earning Info" bottom sheet: what the rider earned from one order.
class EarningInfoSheet extends StatelessWidget {
  final TransactionModel transaction;

  const EarningInfoSheet({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final rows = [
      ["Order Value", "₹${transaction.orderValue}"],
      ["Order Earnings", "₹${transaction.orderEarnings}"],
      ["Incentives", "₹${transaction.incentives}"],
      ["Customer Tips", "₹${transaction.tips}"],
      ["Bonus", "₹${transaction.bonus}"],
    ];
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: OnestText(
                      text: "Earning Info",
                      color: Colors.black,
                      fontSize: ResponsiveFontSizes.fontSize20(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
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

              const SizedBox(height: 10),

              Container(
                width: width,
                padding: const EdgeInsets.fromLTRB(12, 12, 16, 4),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AssetImagePath.orderIcon,
                          height: 32,
                          width: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OnestText(
                                text: transaction.orderId,
                                color: myColors?.txt,
                                fontSize: ResponsiveFontSizes.fontSize17(
                                  context,
                                ),
                                fontWeight: FontWeight.w700,
                                lineHeight: 1.4,
                              ),
                              OnestText(
                                text: transaction.fullDateText,
                                color: const Color(0xff4B5563),
                                fontSize: ResponsiveFontSizes.fontSize13(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                                lineHeight: 1.4,
                              ),
                            ],
                          ),
                        ),
                        OnestText(
                          text: "₹${transaction.earned}",
                          color: myColors?.green,
                          fontSize: ResponsiveFontSizes.fontSize55(context),
                          fontWeight: FontWeight.w700,
                          lineHeight: 1.2,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    for (int i = 0; i < rows.length; i++) ...[
                      if (i != 0)
                        Container(height: 1, color: const Color(0xffE5E7EB)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Row(
                          children: [
                            Expanded(
                              child: OnestText(
                                text: rows[i][0],
                                color: const Color(0xff4B5563),
                                fontSize: ResponsiveFontSizes.fontSize17(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            OnestText(
                              text: rows[i][1],
                              color: i == 0
                                  ? const Color(0xff4B5563)
                                  : myColors?.txt,
                              fontSize: ResponsiveFontSizes.fontSize17(context),
                              fontWeight: i == 0
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
