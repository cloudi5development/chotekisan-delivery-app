import 'package:chotekisan_delivery_app/Screen/Basic_Information/basic_information_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/custom_textfield.dart';
import 'package:chotekisan_delivery_app/common/registration_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BasicInformationScreen extends GetView<BasicInformationController> {
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
            RegistrationHeader(step: 1, onBack: controller.onBack),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 22, 16, 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnestText(
                          text: "Basic Information",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize22(context),
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.2,
                        ),
                        SizedBox(height: 2),
                        OnestText(
                          text: "Please provide your personal details",
                          color: myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize14(context),
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.35,
                        ),

                        SizedBox(height: 14),

                        OnestText(
                          text: "Personal Details",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Full Name",
                          hintText: "Enter your full name",
                          isRequired: true,
                          textEditingController: controller.fullNameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),

                        SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Mobile Number",
                          hintText: "Enter your mobile number",
                          isRequired: true,
                          textEditingController: controller.mobileController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),

                        SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Email Address (optional)",
                          hintText: "Enter your email address",
                          textEditingController: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Date of Birth",
                          hintText: "dd-mm-yyyy",
                          isRequired: true,
                          textEditingController: controller.dobController,
                          readOnly: true,
                          onTap: () => controller.pickDateOfBirth(context),
                          suffixIcon: Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: Color(0xff374151),
                          ),
                        ),

                        SizedBox(height: 12),

                        Obx(
                          () => CustomLabelDropdown(
                            label: "Gender (optional)",
                            value: controller.gender.value,
                            items: controller.genderList,
                            onChanged: (value) =>
                                controller.gender.value = value,
                          ),
                        ),

                        SizedBox(height: 24),

                        OnestText(
                          text: "Address Details",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Building/Floor No",
                          hintText: "e.g., 123, raja street",
                          isRequired: true,
                          textEditingController: controller.buildingController,
                        ),

                        SizedBox(height: 12),

                        Obx(
                          () => CustomLabelDropdown(
                            label: "State",
                            isRequired: true,
                            value: controller.state.value,
                            items: controller.stateList,
                            onChanged: controller.onStateChanged,
                          ),
                        ),

                        SizedBox(height: 12),

                        Obx(
                          () => CustomLabelDropdown(
                            label: "District",
                            isRequired: true,
                            value: controller.district.value,
                            items: controller.districtList,
                            onChanged: (value) =>
                                controller.district.value = value,
                          ),
                        ),

                        SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "PIN Code",
                          hintText: "Enter your PIN code",
                          isRequired: true,
                          textEditingController: controller.pinCodeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
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
