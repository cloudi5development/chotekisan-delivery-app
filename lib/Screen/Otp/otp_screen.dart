import 'package:chotekisan_delivery_app/Screen/Otp/otp_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),

      body: Obx(
        () => controller.isRedirecting.value
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        strokeCap: StrokeCap.round,
                        color: myColors?.green,
                      ),
                    ),
                    SizedBox(height: 8),
                    OnestText(
                      text: "Redirecting you to your dashboard...",
                      color: Color(0xff4B5563),
                      fontSize: ResponsiveFontSizes.fontSize17(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              )
            : SafeArea(
                top: false,
                child: Stack(
                  children: [
                    if (!keyboardOpen)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0x00F8F9FB), Color(0xffF8F9FB)],
                              stops: [0.72, 1.0],
                            ),
                          ),
                          child: Image.asset(
                            AssetImagePath.loginDeliveryPerson,
                            height: height * 0.49,
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomCenter,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  AssetImagePath.freelanceDeliveryPerson,
                                  height: height * 0.49,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.bottomCenter,
                                ),
                          ),
                        ),
                      ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 2),
                            Image.asset(
                              AssetImagePath.appLogo,
                              height: height * 0.15,
                              width: width * 0.4,
                            ),

                            SizedBox(height: 28),

                            OnestText(
                              text: "Verify Your Number",
                              color: myColors?.txt,
                              fontSize: ResponsiveFontSizes.fontSize24(context),
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 4),
                            OnestText(
                              textAlign: TextAlign.center,
                              text: "Enter the 4-digit OTP sent to",
                              color: myColors?.primaryText,
                              fontSize: ResponsiveFontSizes.fontSize13(context),
                              fontWeight: FontWeight.w400,
                            ),
                            OnestText(
                              textAlign: TextAlign.center,
                              text: controller.maskedMobile,
                              color: myColors?.primaryText,
                              fontSize: ResponsiveFontSizes.fontSize13(context),
                              fontWeight: FontWeight.w700,
                            ),

                            SizedBox(height: 20),

                            Stack(
                              children: [
                                Row(
                                  children: [
                                    for (int i = 0; i < 4; i++) ...[
                                      if (i != 0) SizedBox(width: 20),
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color:
                                                    controller
                                                            .errorText
                                                            .value !=
                                                        null
                                                    ? myColors?.error ??
                                                          Colors.red
                                                    : controller
                                                              .hasFocus
                                                              .value &&
                                                          i ==
                                                              controller
                                                                  .otp
                                                                  .value
                                                                  .length
                                                    ? myColors?.green ??
                                                          Colors.green
                                                    : myColors?.borderGray ??
                                                          Colors.black12,
                                                width: 1.2,
                                              ),
                                            ),
                                            child:
                                                i < controller.otp.value.length
                                                ? OnestText(
                                                    text:
                                                        controller.otp.value[i],
                                                    color: myColors?.txt,
                                                    fontSize:
                                                        ResponsiveFontSizes.fontSize19(
                                                          context,
                                                        ),
                                                    fontWeight: FontWeight.w500,
                                                  )
                                                : controller.hasFocus.value &&
                                                      i ==
                                                          controller
                                                              .otp
                                                              .value
                                                              .length
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
                                    onChanged: controller.onOtpChanged,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    style: TextStyle(color: Colors.transparent),
                                    decoration: InputDecoration(
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

                            SizedBox(height: 8),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: controller.errorText.value != null
                                  ? OnestText(
                                      textAlign: TextAlign.start,
                                      text: controller.errorText.value,
                                      color: myColors?.error,
                                      fontSize: ResponsiveFontSizes.fontSize13(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OnestText(
                                          text: "Didn’t receive the code? ",
                                          color: Color(0xff4B5563),
                                          fontSize:
                                              ResponsiveFontSizes.fontSize13(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        GestureDetector(
                                          onTap:
                                              controller.secondsLeft.value == 0
                                              ? controller.resendOtp
                                              : null,
                                          child: OnestText(
                                            text:
                                                controller.secondsLeft.value ==
                                                    0
                                                ? "Resend"
                                                : "Resend in ${controller.timerText}",
                                            color: myColors?.primary,
                                            fontSize:
                                                ResponsiveFontSizes.fontSize13(
                                                  context,
                                                ),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),

                            Spacer(),

                            controller.isExpired.value
                                ? CustomButton(
                                    text: "Resend OTP",
                                    height: 48,
                                    width: width,
                                    bgcolor: myColors?.green,
                                    textcolor: Colors.white,
                                    borderRadius: 16,
                                    onPressed: controller.resendOtp,
                                  )
                                : CustomButton(
                                    text: "Verify & Continue",
                                    height: 48,
                                    width: width,
                                    bgcolor:
                                        controller.otp.value.length == 4 &&
                                            controller.errorText.value == null
                                        ? myColors?.green
                                        : Color(0xffD1D5DB),
                                    textcolor:
                                        controller.otp.value.length == 4 &&
                                            controller.errorText.value == null
                                        ? Colors.white
                                        : Color(0xff9CA3AF),
                                    borderRadius: 16,
                                    onPressed:
                                        controller.otp.value.length == 4 &&
                                            controller.errorText.value == null
                                        ? controller.verifyOtp
                                        : null,
                                  ),

                            SizedBox(height: 10),

                            Row(
                              children: [
                                OnestText(
                                  text: "By continuing, you agree to our ",
                                  color: Color(0xff4B5563),
                                  fontSize: ResponsiveFontSizes.fontSize13(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: OnestText(
                                    text: "Terms & Privacy Policy",
                                    color: myColors?.primary,
                                    fontSize: ResponsiveFontSizes.fontSize13(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20),
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
