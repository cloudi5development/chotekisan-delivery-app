import 'package:chotekisan_delivery_app/Screen/Declaration/declaration_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/registration_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeclarationScreen extends GetView<DeclarationController> {
  const DeclarationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            RegistrationHeader(step: 5, onBack: controller.onBack),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 22, 16, 150),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnestText(
                          text: "Declaration",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize22(context),
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.2,
                        ),
                        SizedBox(height: 2),
                        OnestText(
                          text: "Please review and submit",
                          color: myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize14(context),
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.35,
                        ),

                        SizedBox(height: 6),

                        // The artwork is full screen width, so scale it past
                        // the page padding
                        Transform.scale(
                          scale: width / (width - 32),
                          child: Image.asset(
                            AssetImagePath.declarationBg,
                            width: width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),

                        SizedBox(height: 28),

                        declarationCard(
                          context,
                          value: controller.confirmAccurate,
                          child: OnestText(
                            text:
                                "I confirm that the information provided is accurate and true.",
                            color: Color(0xff374151),
                            fontSize: ResponsiveFontSizes.fontSize15(context),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: 12),

                        declarationCard(
                          context,
                          value: controller.understandSuspension,
                          child: OnestText(
                            text:
                                "I understand that any false information may lead to account suspension.",
                            color: Color(0xff374151),
                            fontSize: ResponsiveFontSizes.fontSize15(context),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: 12),

                        declarationCard(
                          context,
                          value: controller.agreeTerms,
                          child: Text.rich(
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
                                  text: "I agree to the Delivery Partner ",
                                ),
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(
                                    color: myColors?.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: myColors?.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(text: "."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InfoNoteBox(
                          text:
                              "Kindly review and submit the application, Once submitted you can’t edit the provided details.",
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: "Submit Application",
                          height: 48,
                          width: width,
                          bgcolor: myColors?.green,
                          textcolor: Colors.white,
                          borderRadius: 16,
                          onPressed: () =>
                              controller.submitApplication(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget declarationCard(
    BuildContext context, {
    required RxBool value,
    required Widget child,
  }) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return GestureDetector(
      onTap: () => value.toggle(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 11, 12, 11),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Obx(
              () => Container(
                height: 19,
                width: 19,
                decoration: BoxDecoration(
                  color: value.value ? myColors?.green : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: value.value
                        ? myColors?.green ?? Colors.green
                        : Color(0xffE5E7EB),
                    width: 1.2,
                  ),
                ),
                child: value.value
                    ? Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ),

            SizedBox(width: 12),

            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
