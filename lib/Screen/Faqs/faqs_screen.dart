import 'package:chotekisan_delivery_app/Screen/Faqs/faqs_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqsScreen extends GetView<FaqsController> {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const CustomAppHeader(
              title: "FAQs",
              showBack: true,
              showSupport: false,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Obx(
                    () => Column(
                      children: [
                        for (int i = 0; i < controller.faqs.length; i++) ...[
                          if (i > 0)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(0xffF0F1F3),
                              ),
                            ),
                          InkWell(
                            onTap: () => controller.toggle(i),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                14,
                                16,
                                14,
                                16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OnestText(
                                          text: controller.faqs[i].question,
                                          color: myColors?.txt,
                                          fontSize:
                                              ResponsiveFontSizes.fontSize17(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w600,
                                          lineHeight: 1.35,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        controller.expandedIndex.value == i
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons
                                                  .keyboard_arrow_down_rounded,
                                        size: 24,
                                        color: myColors?.txt,
                                      ),
                                    ],
                                  ),

                                  if (controller.expandedIndex.value == i) ...[
                                    const SizedBox(height: 8),
                                    OnestText(
                                      text: controller.faqs[i].answer,
                                      color: myColors?.primaryText,
                                      fontSize: ResponsiveFontSizes.fontSize16(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w400,
                                      lineHeight: 1.45,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
