import 'package:chotekisan_delivery_app/Screen/Day_Earnings/day_earnings_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:chotekisan_delivery_app/common/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DayEarningsScreen extends GetView<DayEarningsController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final day = controller.day;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: Column(
          children: [
            CustomAppHeader(
              title: controller.title,
              showBack: true,
              showSupport: false,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  24 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: OnestText(
                            text: day.label,
                            color: myColors?.txt,
                            fontSize: ResponsiveFontSizes.fontSize20(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        OnestText(
                          text: "₹${day.amount}",
                          color: myColors?.green,
                          fontSize: ResponsiveFontSizes.fontSize20(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          if (day.transactions.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                bottom: 36,
                              ),
                              child: OnestText(
                                text: "No transaction on this day.",
                                color: myColors?.primaryText,
                                fontSize: ResponsiveFontSizes.fontSize14(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                          for (final transaction
                              in day.transactions.reversed) ...[
                            TransactionCard(
                              transaction: transaction,
                              timeText: transaction.timeText,
                              onTap: () =>
                                  controller.onTransactionTap(transaction),
                            ),
                            SizedBox(height: 12),
                          ],
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
