import 'package:chotekisan_delivery_app/Screen/Login/login_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),

      body: SafeArea(
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
                    errorBuilder: (context, error, stackTrace) => Image.asset(
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
                    SizedBox(
                      width: width,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Image.asset(
                              AssetImagePath.appLogo,
                              height: height * 0.15,
                              width: width * 0.4,
                            ),
                          ),

                          Positioned(
                            left: 0,
                            top: 40,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => Get.back(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: myColors?.txt,
                                  ),
                                  SizedBox(width: 6),
                                  OnestText(
                                    text: "Back",
                                    color: myColors?.txt,
                                    fontSize: ResponsiveFontSizes.fontSize17(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28),

                    OnestText(
                      text: "Sign in to your account",
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize24(context),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4),
                    OnestText(
                      textAlign: TextAlign.center,
                      text:
                          "Login to manage deliveries, track orders, and stay \nupdated in real time.",
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize13(context),
                      fontWeight: FontWeight.w400,
                    ),

                    SizedBox(height: 20),

                    Obx(
                      () => Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.errorText.value != null
                                ? myColors?.error ?? Colors.red
                                : myColors?.borderGray ?? Colors.black12,
                            width: controller.errorText.value != null ? 1.2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.mobileController,
                                keyboardType: TextInputType.phone,
                                onChanged: controller.onMobileChanged,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                cursorColor: myColors?.green,
                                style: GoogleFonts.onest(
                                  color: myColors?.txt,
                                  fontSize: ResponsiveFontSizes.fontSize17(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: false,
                                  hintText: "Enter your mobile number",
                                  hintStyle: GoogleFonts.onest(
                                    color: Color(0xff9CA3AF),
                                    fontSize: ResponsiveFontSizes.fontSize17(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                            ),

                            if (controller.isValid)
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 24,
                                  color: myColors?.green,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(
                        () => OnestText(
                          textAlign: TextAlign.start,
                          text:
                              controller.errorText.value ??
                              "Enter a valid 10 digit mobile number.",
                          color: controller.errorText.value != null
                              ? myColors?.error
                              : Color(0xff4B5563),
                          fontSize: ResponsiveFontSizes.fontSize13(context),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Row(
                      children: [
                        OnestText(
                          text: "Lost your phone number? ",
                          color: Color(0xff4B5563),
                          fontSize: ResponsiveFontSizes.fontSize13(context),
                          fontWeight: FontWeight.w400,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: OnestText(
                            text: "Reach us",
                            color: myColors?.primary,
                            fontSize: ResponsiveFontSizes.fontSize13(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    Obx(
                      () => CustomButton(
                        text: "Send OTP",
                        height: 48,
                        width: width,
                        bgcolor: controller.mobile.value.isNotEmpty
                            ? myColors?.green
                            : Color(0xffD1D5DB),
                        textcolor: controller.mobile.value.isNotEmpty
                            ? Colors.white
                            : Color(0xff9CA3AF),
                        borderRadius: 16,
                        onPressed: controller.mobile.value.isNotEmpty
                            ? controller.sendOtp
                            : null,
                      ),
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        OnestText(
                          text: "By continuing, you agree to our ",
                          color: Color(0xff4B5563),
                          fontSize: ResponsiveFontSizes.fontSize13(context),
                          fontWeight: FontWeight.w400,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: OnestText(
                            text: "Terms & Privacy Policy",
                            color: myColors?.primary,
                            fontSize: ResponsiveFontSizes.fontSize13(context),
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
    );
  }
}
