import 'package:chotekisan_delivery_app/Screen/Payment_Information/payment_information_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/custom_textfield.dart';
import 'package:chotekisan_delivery_app/common/registration_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentInformationScreen extends GetView<PaymentInformationController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            RegistrationHeader(step: 4, onBack: controller.onBack),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 22, 16, 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnestText(
                          text: "Payment Information",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize22(context),
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.2,
                        ),
                        SizedBox(height: 2),
                        OnestText(
                          text: "Provide your payment details",
                          color: myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize14(context),
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.35,
                        ),

                        SizedBox(height: 14),

                        OnestText(
                          text: "Choose Payment Method",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(height: 12),

                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: controller.paymentMethod.value == 0
                                  ? Color(0xffEEF8F0)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: controller.paymentMethod.value == 0
                                    ? myColors?.green ?? Colors.green
                                    : Colors.grey.shade200,
                                width: controller.paymentMethod.value == 0
                                    ? 1.2
                                    : 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () =>
                                      controller.paymentMethod.value = 0,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AssetImagePath.bank,
                                        height: 41,
                                        width: 41,
                                      ),

                                      SizedBox(width: 16),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            OnestText(
                                              text: "Bank Account",
                                              color: myColors?.txt,
                                              fontSize:
                                                  ResponsiveFontSizes.fontSize16(
                                                    context,
                                                  ),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(height: 2),
                                            OnestText(
                                              text:
                                                  "Receive payments in your \nbank account.",
                                              color: Color(0xff4B5563),
                                              fontSize:
                                                  ResponsiveFontSizes.fontSize14(
                                                    context,
                                                  ),
                                              fontWeight: FontWeight.w400,
                                              lineHeight: 1.35,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 4,
                                        ),
                                        child: Icon(
                                          controller.paymentMethod.value == 0
                                              ? Icons.radio_button_checked
                                              : Icons.circle_outlined,
                                          size: 22,
                                          color:
                                              controller.paymentMethod.value ==
                                                  0
                                              ? myColors?.green
                                              : myColors?.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                if (controller.paymentMethod.value == 0) ...[
                                  SizedBox(height: 16),

                                  CustomLabelTextfield(
                                    label: "Bank Name",
                                    hintText: "Enter bank name",
                                    isRequired: true,
                                    textEditingController:
                                        controller.bankNameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),

                                  SizedBox(height: 12),

                                  CustomLabelTextfield(
                                    label: "Account Holder Name",
                                    hintText: "Enter acc holder name",
                                    isRequired: true,
                                    textEditingController:
                                        controller.accountHolderController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),

                                  SizedBox(height: 12),

                                  CustomLabelTextfield(
                                    label: "Bank Account Number",
                                    hintText: "Enter acc number",
                                    isRequired: true,
                                    textEditingController:
                                        controller.accountNumberController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(18),
                                    ],
                                  ),

                                  SizedBox(height: 12),

                                  CustomLabelTextfield(
                                    label: "IFSC Code",
                                    hintText: "Enter 11 character IFSC Code",
                                    isRequired: true,
                                    textEditingController:
                                        controller.ifscController,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9]'),
                                      ),
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 18),

                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: controller.paymentMethod.value == 1
                                  ? Color(0xffEEF8F0)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: controller.paymentMethod.value == 1
                                    ? myColors?.green ?? Colors.green
                                    : Colors.grey.shade200,
                                width: controller.paymentMethod.value == 1
                                    ? 1.2
                                    : 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () =>
                                      controller.paymentMethod.value = 1,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AssetImagePath.upi,
                                        height: 41,
                                        width: 41,
                                      ),

                                      SizedBox(width: 16),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            OnestText(
                                              text: "UPI",
                                              color: myColors?.txt,
                                              fontSize:
                                                  ResponsiveFontSizes.fontSize16(
                                                    context,
                                                  ),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(height: 2),
                                            OnestText(
                                              text: "Receive payments via UPI.",
                                              color: Color(0xff4B5563),
                                              fontSize:
                                                  ResponsiveFontSizes.fontSize14(
                                                    context,
                                                  ),
                                              fontWeight: FontWeight.w400,
                                              lineHeight: 1.35,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 4,
                                        ),
                                        child: Icon(
                                          controller.paymentMethod.value == 1
                                              ? Icons.radio_button_checked
                                              : Icons.circle_outlined,
                                          size: 22,
                                          color:
                                              controller.paymentMethod.value ==
                                                  1
                                              ? myColors?.green
                                              : myColors?.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                if (controller.paymentMethod.value == 1) ...[
                                  SizedBox(height: 16),

                                  CustomLabelTextfield(
                                    label: "UPI ID",
                                    hintText: "Enter your UPI ID",
                                    isRequired: true,
                                    textEditingController:
                                        controller.upiController,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (!keyboardOpen)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      child: CustomButton(
                        text: "Next",
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
                        onPressed: () => controller.onNext(context),
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
}
