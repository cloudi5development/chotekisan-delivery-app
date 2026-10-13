import 'package:chotekisan_delivery_app/Model/earning_model.dart';
import 'package:chotekisan_delivery_app/Screen/Earnings/earnings_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:chotekisan_delivery_app/common/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EarningsScreen extends GetView<EarningsController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: Column(
          children: [
            CustomAppHeader(title: "Earnings"),

            SizedBox(height: 12),

            // Tabs and filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0; i < controller.tabs.length; i++)
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => controller.selectTab(i),
                          child: Container(
                            height: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color:
                                      !controller.isFiltered.value &&
                                          controller.selectedTab.value == i
                                      ? myColors?.green ?? Colors.green
                                      : Color(0xffE5E7EB),
                                  width:
                                      !controller.isFiltered.value &&
                                          controller.selectedTab.value == i
                                      ? 2
                                      : 1,
                                ),
                              ),
                            ),
                            child: OnestText(
                              text: controller.tabs[i],
                              color:
                                  !controller.isFiltered.value &&
                                      controller.selectedTab.value == i
                                  ? myColors?.green
                                  : Color(0xff4B5563),
                              fontSize: ResponsiveFontSizes.fontSize18(context),
                              fontWeight:
                                  !controller.isFiltered.value &&
                                      controller.selectedTab.value == i
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: controller.openFilter,
                      child: Container(
                        height: 42,
                        width: 50,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xffE5E7EB)),
                          ),
                        ),
                        child: Icon(
                          Icons.filter_list,
                          size: 24,
                          color: controller.isFiltered.value
                              ? myColors?.green
                              : myColors?.txt,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  20 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Earnings card
                      Container(
                        width: width,
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        decoration: BoxDecoration(
                          color: Color(0xff0DA437),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: GestureDetector(
                                    onTap: controller.onPrevious,
                                    child: Opacity(
                                      opacity: controller.canGoPrevious
                                          ? 1
                                          : 0.35,
                                      child: Container(
                                        height: 31,
                                        width: 31,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.12,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.chevron_left,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 2),
                                      OnestText(
                                        textAlign: TextAlign.center,
                                        text: controller.periodTitle,
                                        color: Colors.white,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize15(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w400,
                                        maxLines: 1,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                      OnestText(
                                        text:
                                            "₹${formatAmount(controller.totalEarnings)}",
                                        color: Colors.white,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize55(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.3,
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: GestureDetector(
                                    onTap: controller.onNext,
                                    child: Opacity(
                                      opacity: controller.canGoNext ? 1 : 0.35,
                                      child: Container(
                                        height: 31,
                                        width: 31,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.12,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.chevron_right,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 4),

                            // Dashed line with the show / hide breakdown button
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: controller.toggleExpanded,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: width,
                                    height: 1,
                                    child: CustomPaint(
                                      painter: DashedDividerPainter(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      controller.isExpanded.value
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: 20,
                                      color: Color(0xff0DA437),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if (controller.isExpanded.value) ...[
                              SizedBox(height: 10),
                              breakdownRow(
                                context,
                                "Order Earnings",
                                controller.orderEarnings,
                              ),
                              breakdownRow(
                                context,
                                "Incentives",
                                controller.incentives,
                              ),
                              breakdownRow(
                                context,
                                "Customer Tips",
                                controller.tips,
                              ),
                              breakdownRow(context, "Bonus", controller.bonus),
                            ] else
                              SizedBox(height: 2),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),

                      // Summary
                      Container(
                        width: width,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            OnestText(
                              text: controller.summaryTitle,
                              color: myColors?.txt,
                              fontSize: ResponsiveFontSizes.fontSize13(context),
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 9),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: summaryItem(
                                    context,
                                    "Online Hours",
                                    controller.onlineHoursText,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 50,
                                  color: Color(0xffE5E7EB),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: summaryItem(
                                    context,
                                    "Order Completed",
                                    controller.ordersCompletedText,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 50,
                                  color: Color(0xffE5E7EB),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: summaryItem(
                                    context,
                                    "Payout Cycle",
                                    "${controller.payoutDaysLeft.value}",
                                    suffix: " days left",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      OnestText(
                        text: controller.sectionTitle,
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize20(context),
                        fontWeight: FontWeight.w600,
                      ),

                      SizedBox(height: 12),

                      if (controller.transactions.isEmpty)
                        // Nothing earned in this period
                        Container(
                          width: width,
                          padding: const EdgeInsets.fromLTRB(16, 30, 16, 36),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                AssetImagePath.noTransaction,
                                width: width * 0.56,
                              ),
                              SizedBox(height: 12),
                              OnestText(
                                textAlign: TextAlign.center,
                                text: controller.emptyTitle,
                                color: Color(0xff374151),
                                fontSize: ResponsiveFontSizes.fontSize22(
                                  context,
                                ),
                                fontWeight: FontWeight.w600,
                                lineHeight: 1.3,
                              ),
                              SizedBox(height: 6),
                              OnestText(
                                textAlign: TextAlign.center,
                                text:
                                    "Complete deliveries to see your earnings here.",
                                color: myColors?.primaryText,
                                fontSize: ResponsiveFontSizes.fontSize14(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                                lineHeight: 1.35,
                              ),
                            ],
                          ),
                        )
                      else if (controller.showsTransactions)
                        // Orders of the day, or of the filtered date range
                        Container(
                          width: width,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              for (final transaction
                                  in controller.showAllTransactions.value
                                      ? controller.transactions
                                      : controller.transactions.take(5)) ...[
                                TransactionCard(
                                  transaction: transaction,
                                  timeText: controller.isFiltered.value
                                      ? transaction.dateTimeText
                                      : transaction.timeText,
                                  onTap: () =>
                                      controller.onTransactionTap(transaction),
                                ),
                                SizedBox(height: 12),
                              ],

                              if (!controller.showAllTransactions.value &&
                                  controller.transactions.length > 5)
                                GestureDetector(
                                  onTap: controller.onViewAllTransactions,
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFDF0E2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        OnestText(
                                          text: "View All Transaction",
                                          color: myColors?.primary,
                                          fontSize:
                                              ResponsiveFontSizes.fontSize18(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 22,
                                          color: myColors?.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      else
                        // Day by day list for the week or month
                        Container(
                          width: width,
                          padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              for (final day in controller.periodDays) ...[
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => controller.onDayTap(day),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 11,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              OnestText(
                                                text: day.label,
                                                color: Color(0xff374151),
                                                fontSize:
                                                    ResponsiveFontSizes.fontSize17(
                                                      context,
                                                    ),
                                                fontWeight: FontWeight.w400,
                                                lineHeight: 1.4,
                                              ),
                                              OnestText(
                                                text:
                                                    "${day.onlineHoursText} online hours",
                                                color: myColors?.primaryText,
                                                fontSize:
                                                    ResponsiveFontSizes.fontSize14(
                                                      context,
                                                    ),
                                                fontWeight: FontWeight.w400,
                                                lineHeight: 1.4,
                                              ),
                                            ],
                                          ),
                                        ),
                                        OnestText(
                                          text: "₹${day.amount}",
                                          color: Color(0xff374151),
                                          fontSize:
                                              ResponsiveFontSizes.fontSize18(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(width: 12),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: myColors?.txt,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (day != controller.periodDays.last)
                                  SizedBox(
                                    width: width,
                                    height: 1,
                                    child: CustomPaint(
                                      painter: DashedDividerPainter(
                                        color: Color(0xffD1D5DB),
                                      ),
                                    ),
                                  ),
                              ],

                              Container(height: 1, color: Color(0xffD1D5DB)),
                              SizedBox(height: 14),

                              Row(
                                children: [
                                  Expanded(
                                    child: OnestText(
                                      text: "Total Earnings",
                                      color: myColors?.txt,
                                      fontSize: ResponsiveFontSizes.fontSize17(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  OnestText(
                                    text:
                                        "₹${formatAmount(controller.totalEarnings)}",
                                    color: myColors?.txt,
                                    fontSize: ResponsiveFontSizes.fontSize30(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w700,
                                    lineHeight: 1.2,
                                  ),
                                ],
                              ),
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

  Widget breakdownRow(BuildContext context, String label, int amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: OnestText(
              text: label,
              color: Colors.white,
              fontSize: ResponsiveFontSizes.fontSize16(context),
              fontWeight: FontWeight.w400,
            ),
          ),
          OnestText(
            text: "₹${formatAmount(amount)}",
            color: Colors.white,
            fontSize: ResponsiveFontSizes.fontSize16(context),
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget summaryItem(
    BuildContext context,
    String label,
    String value, {
    String? suffix,
  }) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Column(
      children: [
        OnestText(
          text: label,
          color: Color(0xff4B5563),
          fontSize: ResponsiveFontSizes.fontSize14(context),
          fontWeight: FontWeight.w400,
          lineHeight: 1.35,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            OnestText(
              text: value,
              color: myColors?.txt,
              fontSize: ResponsiveFontSizes.fontSize18(context),
              fontWeight: FontWeight.w600,
              lineHeight: 1.3,
            ),
            if (suffix != null)
              OnestText(
                text: suffix,
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize14(context),
                fontWeight: FontWeight.w400,
                lineHeight: 1.5,
              ),
          ],
        ),
      ],
    );
  }
}
