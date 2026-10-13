import 'package:chotekisan_delivery_app/Screen/Delivery_Closed/delivery_closed_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryClosedScreen extends GetView<DeliveryClosedController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final order = controller.order;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) controller.onBackToHome();
      },
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: SafeArea(
          top: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.443),

                  OnestText(
                    text: order.isCod
                        ? "COD Delivery Closed"
                        : "Delivery Closed",
                    color: Colors.black,
                    fontSize: ResponsiveFontSizes.fontSize22(context),
                    fontWeight: FontWeight.w600,
                    lineHeight: 1.35,
                  ),
                  OnestText(
                    text: "Successfully!",
                    color: myColors?.greenColor,
                    fontSize: ResponsiveFontSizes.fontSize22(context),
                    fontWeight: FontWeight.w700,
                    lineHeight: 1.35,
                  ),

                  SizedBox(height: 10),

                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: GoogleFonts.onest(
                        letterSpacing: 0,
                        height: 1.35,
                        color: myColors?.primaryText,
                        fontSize: ResponsiveFontSizes.fontSize14(context),
                        fontWeight: FontWeight.w400,
                      ),
                      children: order.isCod
                          ? [
                              TextSpan(text: "Cash collected and delivery of "),
                              TextSpan(
                                text: order.orderId,
                                style: TextStyle(
                                  color: Color(0xff4B5563),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: " has been\ncompleted."),
                            ]
                          : [
                              TextSpan(
                                text:
                                    "The delivery has been completed and the\n",
                              ),
                              TextSpan(
                                text: order.orderId,
                                style: TextStyle(
                                  color: Color(0xff4B5563),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: " is closed"),
                            ],
                    ),
                  ),

                  SizedBox(height: 21),

                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF0FDF4),
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 41,
                          width: 41,
                          decoration: BoxDecoration(
                            color: Color(0xffDCF1E2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified_user,
                            size: 24,
                            color: Color(0xff86D29B),
                          ),
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OnestText(
                                text: "OTP Verified",
                                color: myColors?.txt,
                                fontSize: ResponsiveFontSizes.fontSize16(
                                  context,
                                ),
                                fontWeight: FontWeight.w700,
                                lineHeight: 1.4,
                              ),
                              OnestText(
                                text: "Delivery verified and closed.",
                                color: Color(0xff4B5563),
                                fontSize: ResponsiveFontSizes.fontSize16(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                                lineHeight: 1.4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  CustomButton(
                    text: "Back to Home",
                    height: 48,
                    width: width,
                    bgcolor: myColors?.green,
                    textcolor: Colors.white,
                    borderRadius: 16,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: controller.onBackToHome,
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
