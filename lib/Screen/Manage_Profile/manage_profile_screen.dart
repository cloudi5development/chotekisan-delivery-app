import 'package:chotekisan_delivery_app/Screen/Manage_Profile/manage_profile_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/custom_textfield.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ManageProfileScreen extends GetView<ManageProfileController> {
  const ManageProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const CustomAppHeader(title: "Manage Profile", showBack: true),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 22, 16, 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar with the change-photo badge.
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const CircleAvatar(
                                radius: 54,
                                backgroundImage: AssetImage(
                                  AssetImagePath.profileImage,
                                ),
                              ),
                              Positioned(
                                right: -2,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: controller.onChangePhoto,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: myColors?.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.5,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.photo_camera_outlined,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        OnestText(
                          text: "Personal Details",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        const SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Full Name",
                          hintText: "Enter your full name",
                          isRequired: true,
                          textEditingController: controller.fullNameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),

                        const SizedBox(height: 12),

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

                        const SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Email Address (optional)",
                          hintText: "Enter your email address",
                          textEditingController: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Date of Birth",
                          hintText: "dd-mm-yyyy",
                          isRequired: true,
                          textEditingController: controller.dobController,
                          readOnly: true,
                          onTap: () => controller.pickDateOfBirth(context),
                          suffixIcon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: Color(0xff374151),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Obx(
                          () => CustomLabelDropdown(
                            label: "Gender (optional)",
                            value: controller.gender.value,
                            items: controller.genderList,
                            onChanged: (value) =>
                                controller.gender.value = value,
                          ),
                        ),

                        const SizedBox(height: 24),

                        OnestText(
                          text: "Address Details",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        const SizedBox(height: 12),

                        CustomLabelTextfield(
                          label: "Building/Floor No",
                          hintText: "e.g., 123, raja street",
                          isRequired: true,
                          textEditingController: controller.buildingController,
                        ),

                        const SizedBox(height: 12),

                        Obx(
                          () => CustomLabelDropdown(
                            label: "State",
                            isRequired: true,
                            value: controller.state.value,
                            items: controller.stateList,
                            onChanged: controller.onStateChanged,
                          ),
                        ),

                        const SizedBox(height: 12),

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

                        const SizedBox(height: 12),

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
                        text: "Update Profile",
                        height: 48,
                        width: width,
                        bgcolor: myColors?.green,
                        textcolor: Colors.white,
                        borderRadius: 24,
                        onPressed: () => controller.onUpdateProfile(context),
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
