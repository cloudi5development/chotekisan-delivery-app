import 'package:chotekisan_delivery_app/Screen/Order_Details/order_details_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// "Verify to Close Delivery" bottom sheet: customer OTP, plus the collected
/// cash summary for COD orders.
class VerifyCloseSheet extends GetView<OrderDetailsController> {
  const VerifyCloseSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final order = controller.order;
    return Padding(
      // Lift the sheet above the keyboard
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        width: width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OnestText(
                  textAlign: TextAlign.center,
                  text: "Verify to Close Delivery",
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize22(context),
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.3,
                ),
                const SizedBox(height: 6),
                OnestText(
                  textAlign: TextAlign.center,
                  text: "Please enter the OTP sent to customer’s\nmobile number",
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize14(context),
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.35,
                ),

                const SizedBox(height: 16),

                if (order.isCod) ...[
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F4F6),
                      border: Border.all(color: const Color(0xffE5E7EB)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OnestText(
                                text: "Cash Collected",
                                color: myColors?.txt,
                                fontSize: ResponsiveFontSizes.fontSize18(
                                  context,
                                ),
                                fontWeight: FontWeight.w500,
                                lineHeight: 1.35,
                              ),
                              OnestText(
                                text: order.collectedVia ?? "In-hand",
                                color: const Color(0xff4B5563),
                                fontSize: ResponsiveFontSizes.fontSize15(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                                lineHeight: 1.35,
                              ),
                            ],
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
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xffE5E7EB),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: OnestText(
                          text: "Then verify to close",
                          color: myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize14(context),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xffE5E7EB),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                ],

                // OTP boxes
                Stack(
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          for (int i = 0; i < 4; i++) ...[
                            if (i != 0) const SizedBox(width: 21),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color:
                                          controller.hasFocus.value &&
                                              i == controller.otp.value.length
                                          ? myColors?.green ?? Colors.green
                                          : myColors?.borderGray ??
                                                Colors.black12,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: i < controller.otp.value.length
                                      ? OnestText(
                                          text: controller.otp.value[i],
                                          color: myColors?.txt,
                                          fontSize:
                                              ResponsiveFontSizes.fontSize19(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w500,
                                        )
                                      : controller.hasFocus.value &&
                                            i == controller.otp.value.length
                                      ? Container(
                                          width: 1.5,
                                          height: 24,
                                          color: myColors?.txt,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Invisible field that captures the OTP input
                    Positioned.fill(
                      child: TextField(
                        controller: controller.otpController,
                        focusNode: controller.otpFocusNode,
                        autofocus: true,
                        expands: true,
                        maxLines: null,
                        showCursor: false,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => controller.otp.value = value,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        style: const TextStyle(color: Colors.transparent),
                        decoration: const InputDecoration(
                          counterText: "",
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Obx(
                  () => GestureDetector(
                    onTap: controller.secondsLeft.value == 0
                        ? controller.resendOtp
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.secondsLeft.value != 0)
                          OnestText(
                            text: "Resend OTP in ",
                            color: const Color(0xff4B5563),
                            fontSize: ResponsiveFontSizes.fontSize15(context),
                            fontWeight: FontWeight.w400,
                          ),
                        OnestText(
                          text: controller.secondsLeft.value == 0
                              ? "Resend OTP"
                              : controller.timerText,
                          color: myColors?.primary,
                          fontSize: ResponsiveFontSizes.fontSize15(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Obx(
                  () => CustomButton(
                    text: "Verify & Close Delivery",
                    height: 48,
                    width: width,
                    bgcolor: controller.otp.value.length == 4
                        ? myColors?.green
                        : const Color(0xffD1D5DB),
                    textcolor: controller.otp.value.length == 4
                        ? Colors.white
                        : const Color(0xff9CA3AF),
                    borderRadius: 16,
                    onPressed: controller.otp.value.length == 4
                        ? controller.verifyAndClose
                        : null,
                  ),
                ),

                const SizedBox(height: 11),

                GestureDetector(
                  onTap: () => Get.back(),
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
                      text: "Cancel",
                      color: myColors?.green,
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
