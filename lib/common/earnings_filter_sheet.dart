import 'package:chotekisan_delivery_app/Screen/Earnings/earnings_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// "Filter" bottom sheet on the Earnings screen: a from / to date range.
class EarningsFilterSheet extends GetView<EarningsController> {
  const EarningsFilterSheet({super.key});

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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 34,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: OnestText(
                          text: "Filter",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize22(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
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
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                OnestText(
                  text: "Date Range",
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize18(context),
                  fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    for (int i = 0; i < 2; i++) ...[
                      if (i != 0) const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              controller.pickFilterDate(context, i == 0),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: myColors?.borderGray ?? Colors.black12,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OnestText(
                                  text: i == 0 ? "From" : "To",
                                  color: myColors?.primaryText,
                                  fontSize: ResponsiveFontSizes.fontSize14(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OnestText(
                                        text: controller.filterDateText(
                                          i == 0
                                              ? controller.draftFrom.value
                                              : controller.draftTo.value,
                                        ),
                                        color:
                                            (i == 0
                                                    ? controller.draftFrom.value
                                                    : controller
                                                          .draftTo
                                                          .value) ==
                                                null
                                            ? const Color(0xff9CA3AF)
                                            : myColors?.txt,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize17(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w400,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 20,
                                      color: Color(0xff4B5563),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 18),

                CustomButton(
                  text: "Apply Filter",
                  height: 48,
                  width: width,
                  bgcolor: controller.canApplyFilter
                      ? myColors?.green
                      : const Color(0xffD1D5DB),
                  textcolor: controller.canApplyFilter
                      ? Colors.white
                      : const Color(0xff9CA3AF),
                  borderRadius: 16,
                  onPressed: controller.canApplyFilter
                      ? controller.applyFilter
                      : null,
                ),

                const SizedBox(height: 11),

                GestureDetector(
                  onTap: controller.clearFilter,
                  child: Container(
                    height: 48,
                    width: width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF8F0),
                      border: Border.all(color: const Color(0xffCFEAD6)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: OnestText(
                      text: "Clear Filter",
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
