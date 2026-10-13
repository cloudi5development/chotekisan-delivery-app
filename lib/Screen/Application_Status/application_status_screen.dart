import 'package:chotekisan_delivery_app/Screen/Application_Status/application_status_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationStatusScreen extends GetView<ApplicationStatusController> {
  const ApplicationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),

      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: controller.isVerified.value
                        ? height * 0.495
                        : height * 0.343,
                  ),

                  OnestText(
                    text: "Application",
                    color: Colors.black,
                    fontSize: ResponsiveFontSizes.fontSize22(context),
                    fontWeight: FontWeight.w600,
                    lineHeight: 1.35,
                  ),
                  OnestText(
                    text: controller.isVerified.value
                        ? "Successfully Verified!"
                        : "Successfully Submitted!",
                    color: myColors?.greenColor,
                    fontSize: ResponsiveFontSizes.fontSize22(context),
                    fontWeight: FontWeight.w700,
                    lineHeight: 1.35,
                  ),

                  SizedBox(height: 10),

                  OnestText(
                    textAlign: TextAlign.center,
                    text: controller.isVerified.value
                        ? "Your application has been approved. You are now ready to start accepting deliveries."
                        : "Thank you! Your application is now under review. Our team will verify your details and documents.",
                    color: myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize14(context),
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.35,
                  ),

                  if (!controller.isVerified.value) ...[
                    SizedBox(height: 24),

                    Container(
                      width: width,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                              Icons.access_time_filled,
                              size: 24,
                              color: Color(0xff86D29B),
                            ),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: GoogleFonts.onest(
                                      letterSpacing: 0,
                                      height: 1.5,
                                      color: Color(0xff374151),
                                      fontSize: ResponsiveFontSizes.fontSize15(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "You will receive a verification call within ",
                                      ),
                                      TextSpan(
                                        text: "24 - 48 hours.",
                                        style: TextStyle(
                                          color: myColors?.green,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 2),
                                OnestText(
                                  text: "Please keep your phone nearby.",
                                  color: myColors?.primaryText,
                                  fontSize: ResponsiveFontSizes.fontSize14(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  lineHeight: 1.35,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    Container(
                      width: width,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                            child: OnestText(
                              text:
                                  "You will be notified once your application is approved.",
                              color: Color(0xff374151),
                              fontSize: ResponsiveFontSizes.fontSize15(context),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  Spacer(),

                  if (!controller.isVerified.value) ...[
                    InfoNoteBox(
                      text:
                          "Once verified, you can login via Mobile Number using OTP verification.",
                    ),
                    SizedBox(height: 10),
                  ],

                  CustomButton(
                    text: "Login",
                    height: 48,
                    width: width,
                    bgcolor: controller.isVerified.value
                        ? myColors?.green
                        : Color(0xffD1D5DB),
                    textcolor: controller.isVerified.value
                        ? Colors.white
                        : Color(0xff9CA3AF),
                    borderRadius: 16,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: controller.isVerified.value
                            ? Colors.white
                            : Color(0xff9CA3AF),
                      ),
                    ),
                    onPressed: controller.isVerified.value
                        ? controller.onLogin
                        : null,
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
