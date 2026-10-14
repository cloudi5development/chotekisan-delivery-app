import 'package:chotekisan_delivery_app/Screen/Update_Vehicle_Details/update_vehicle_details_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/custom_textfield.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UpdateVehicleDetailsScreen
    extends GetView<UpdateVehicleDetailsController> {
  const UpdateVehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    const calendarIcon = Icon(
      Icons.calendar_month_outlined,
      size: 20,
      color: Color(0xff374151),
    );
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const CustomAppHeader(
              title: "Update Vehicle Details",
              showBack: true,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnestText(
                      text: "Vehicle Type",
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize18(context),
                      fontWeight: FontWeight.w600,
                    ),

                    const SizedBox(height: 12),

                    for (int row = 0; row < 2; row++) ...[
                      if (row != 0) const SizedBox(height: 11),
                      Row(
                        children: [
                          for (int i = row * 2; i < row * 2 + 2; i++) ...[
                            if (i.isOdd) const SizedBox(width: 11),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.vehicleType.value = i,
                                child: Obx(
                                  () => Container(
                                    height: 115,
                                    decoration: BoxDecoration(
                                      color: controller.vehicleType.value == i
                                          ? const Color(0xffEEF8F0)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: controller.vehicleType.value == i
                                            ? myColors?.green ?? Colors.green
                                            : Colors.grey.shade200,
                                        width: controller.vehicleType.value == i
                                            ? 1.2
                                            : 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 18),
                                        SvgPicture.asset(
                                          controller.vehicleList[i]["icon"]!,
                                          height: 51,
                                        ),
                                        const SizedBox(height: 10),
                                        OnestText(
                                          text:
                                              controller.vehicleList[i]["name"],
                                          color:
                                              controller.vehicleType.value == i
                                              ? myColors?.txt
                                              : const Color(0xff4B5563),
                                          fontSize:
                                              ResponsiveFontSizes.fontSize17(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],

                    const SizedBox(height: 24),

                    OnestText(
                      text: "Vehicle Number",
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize18(context),
                      fontWeight: FontWeight.w600,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "Vehicle Registration No",
                      hintText: "Enter vehicle registration number",
                      isRequired: true,
                      textEditingController: controller.vehicleNumberController,
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9 ]'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "Brand",
                      hintText: "Enter vehicle brand name",
                      textEditingController: controller.brandController,
                      textCapitalization: TextCapitalization.words,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "Model",
                      hintText: "Enter vehicle model name",
                      textEditingController: controller.modelController,
                      textCapitalization: TextCapitalization.words,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "Color",
                      hintText: "Enter vehicle color",
                      textEditingController: controller.colorController,
                      textCapitalization: TextCapitalization.words,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "Year of Manufacture",
                      hintText: "yyyy",
                      textEditingController: controller.yearController,
                      readOnly: true,
                      onTap: () => controller.pickYear(context),
                      suffixIcon: calendarIcon,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "RC Number",
                      hintText: "Enter RC number",
                      textEditingController: controller.rcNumberController,
                      textCapitalization: TextCapitalization.characters,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "Registration Date",
                      hintText: "dd-mm-yyyy",
                      textEditingController:
                          controller.registrationDateController,
                      readOnly: true,
                      onTap: () => controller.pickDate(
                        context,
                        controller.registrationDateController,
                      ),
                      suffixIcon: calendarIcon,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "Insurance Validity",
                      hintText: "dd-mm-yyyy",
                      textEditingController:
                          controller.insuranceValidityController,
                      readOnly: true,
                      onTap: () => controller.pickDate(
                        context,
                        controller.insuranceValidityController,
                        allowFuture: true,
                      ),
                      suffixIcon: calendarIcon,
                    ),

                    const SizedBox(height: 12),

                    CustomLabelTextfield(
                      label: "PUC Validity",
                      hintText: "dd-mm-yyyy",
                      textEditingController: controller.pucValidityController,
                      readOnly: true,
                      onTap: () => controller.pickDate(
                        context,
                        controller.pucValidityController,
                        allowFuture: true,
                      ),
                      suffixIcon: calendarIcon,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: CustomButton(
            text: "Update Vehicle Details",
            height: 48,
            width: width,
            bgcolor: myColors?.green,
            textcolor: Colors.white,
            borderRadius: 12,
            onPressed: () => controller.onUpdate(context),
          ),
        ),
      ),
    );
  }
}
