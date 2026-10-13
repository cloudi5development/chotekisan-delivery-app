import 'package:chotekisan_delivery_app/Screen/Order_Details/order_details_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// "Confirm Cash Collected" bottom sheet shown for COD orders before the
/// delivery OTP.
class CashCollectSheet extends GetView<OrderDetailsController> {
  const CashCollectSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final order = controller.order;
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OnestText(
                textAlign: TextAlign.center,
                text: "Confirm Cash Collected",
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize22(context),
                fontWeight: FontWeight.w600,
                lineHeight: 1.3,
              ),
              const SizedBox(height: 6),
              OnestText(
                textAlign: TextAlign.center,
                text: "Please confirm that the cash collected from\nthe customer",
                color: myColors?.primaryText,
                fontSize: ResponsiveFontSizes.fontSize14(context),
                fontWeight: FontWeight.w400,
                lineHeight: 1.35,
              ),

              const SizedBox(height: 16),

              Container(
                width: width,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: OnestText(
                              text: "Cash to be Collect",
                              color: myColors?.txt,
                              fontSize: ResponsiveFontSizes.fontSize18(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          OnestText(
                            text: "₹${order.collectAmount}",
                            color: myColors?.greenColor,
                            fontSize: ResponsiveFontSizes.fontSize18(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // In-hand
                      GestureDetector(
                        onTap: () => controller.selectCashMode(0),
                        child: Container(
                          height: 43,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xffF3F4F6),
                            border: Border.all(color: const Color(0xffE5E7EB)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 20,
                                color: myColors?.primaryText,
                              ),
                              const SizedBox(width: 14),
                              OnestText(
                                text: "In-hand",
                                color: myColors?.primaryText,
                                fontSize: ResponsiveFontSizes.fontSize18(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 11),

                      // Scan & Collect
                      GestureDetector(
                        onTap: () => controller.selectCashMode(1),
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xffF3F4F6),
                            border: Border.all(
                              color: controller.cashMode.value == 1
                                  ? myColors?.green ?? Colors.green
                                  : const Color(0xffE5E7EB),
                              width: controller.cashMode.value == 1 ? 1.2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 43,
                                child: Row(
                                  children: [
                                    Icon(
                                      controller.cashMode.value == 1
                                          ? Icons.radio_button_checked
                                          : Icons.circle_outlined,
                                      size: 20,
                                      color: controller.cashMode.value == 1
                                          ? myColors?.green
                                          : myColors?.primaryText,
                                    ),
                                    const SizedBox(width: 14),
                                    OnestText(
                                      text: "Scan & Collect",
                                      color: controller.cashMode.value == 1
                                          ? myColors?.green
                                          : myColors?.primaryText,
                                      fontSize: ResponsiveFontSizes.fontSize18(
                                        context,
                                      ),
                                      fontWeight: controller.cashMode.value == 1
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),

                              if (controller.cashMode.value == 1)
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: controller.paymentReceived.value
                                      ? Align(
                                          alignment: const Alignment(0, 0.6),
                                          child: Text.rich(
                                            textAlign: TextAlign.center,
                                            TextSpan(
                                              style: GoogleFonts.onest(
                                                letterSpacing: 0,
                                                height: 1.35,
                                                color: myColors?.txt,
                                                fontSize:
                                                    ResponsiveFontSizes.fontSize22(
                                                      context,
                                                    ),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              children: [
                                                const TextSpan(
                                                  text: "Payment of ",
                                                ),
                                                TextSpan(
                                                  text:
                                                      "₹${order.collectAmount}",
                                                  style: TextStyle(
                                                    color: myColors?.green,
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: "\nReceived!",
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 12,
                                          ),
                                          child: QrImageView(
                                            data: controller.paymentQrData,
                                            padding: EdgeInsets.zero,
                                            backgroundColor: const Color(
                                              0xffF3F4F6,
                                            ),
                                          ),
                                        ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
