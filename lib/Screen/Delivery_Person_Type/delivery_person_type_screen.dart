import 'package:chotekisan_delivery_app/Screen/Delivery_Person_Type/delivery_person_type_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryPersonTypeScreen extends GetView<DeliveryPersonTypeController> {
  const new({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12),
                Image.asset(
                  AssetImagePath.appLogo,
                  height: height * 0.15,
                  width: width * 0.4,
                ),

                SizedBox(height: 20),

                OnestText(
                  text: "How will you Deliver?",
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize24(context),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 4),
                OnestText(
                  textAlign: TextAlign.center,
                  text: "Choose the type the best describes you to \ncontinue.",
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize13(context),
                  fontWeight: FontWeight.w400,
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: () => controller.selectType(0),
                  child: Container(
                    width: width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                AssetImagePath.inhouseDeliveryPerson,
                                height: 98,
                                width: 86,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),

                              SizedBox(width: 8),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OnestText(
                                      text: "In-House Delivery Person",
                                      color: myColors?.txt,
                                      fontSize: ResponsiveFontSizes.fontSize15(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),

                                    SizedBox(height: 4),
                                    OnestText(
                                      textAlign: TextAlign.start,
                                      text:
                                          "I am an in-house delivery \npartner working with \nChoteKisan.",
                                      color: myColors?.primaryText,
                                      fontSize: ResponsiveFontSizes.fontSize13(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Obx(
                            () => Icon(
                              controller.selectedType.value == 0
                                  ? Icons.radio_button_checked
                                  : Icons.circle_outlined,
                              size: 22,
                              color: controller.selectedType.value == 0
                                  ? myColors?.green
                                  : myColors?.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 18),

                GestureDetector(
                  onTap: () => controller.selectType(1),
                  child: Container(
                    width: width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                AssetImagePath.freelanceDeliveryPerson,
                                height: 98,
                                width: 86,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),

                              SizedBox(width: 8),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OnestText(
                                      text: "Freelance Delivery Person",
                                      color: myColors?.txt,
                                      fontSize: ResponsiveFontSizes.fontSize15(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),

                                    SizedBox(height: 4),
                                    OnestText(
                                      textAlign: TextAlign.start,
                                      text:
                                          "I am a freelancer looking \nto deliver and earn on \nmy own.",
                                      color: myColors?.primaryText,
                                      fontSize: ResponsiveFontSizes.fontSize13(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Obx(
                            () => Icon(
                              controller.selectedType.value == 1
                                  ? Icons.radio_button_checked
                                  : Icons.circle_outlined,
                              size: 22,
                              color: controller.selectedType.value == 1
                                  ? myColors?.green
                                  : myColors?.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Spacer(),

                CustomButton(
                  text: "Continue",
                  height: 48,
                  width: width,
                  bgcolor: myColors?.green,
                  textcolor: Colors.white,
                  borderRadius: 16,
                  onPressed: controller.onContinue,
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
