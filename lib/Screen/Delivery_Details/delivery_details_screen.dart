import 'package:chotekisan_delivery_app/Screen/Delivery_Details/delivery_details_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DeliveryDetailsScreen extends GetView<DeliveryDetailsController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final order = controller.order;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: Column(
          children: [
            CustomAppHeader(title: "Delivery Details", showBack: true),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  children: [
                    // Order summary
                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(14, 9, 10, 9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AssetImagePath.orderIcon,
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OnestText(
                                  text: order.orderId,
                                  color: myColors?.txt,
                                  fontSize: ResponsiveFontSizes.fontSize17(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w700,
                                  lineHeight: 1.4,
                                ),
                                OnestText(
                                  text: order.acceptedOn ?? "-",
                                  color: Color(0xff4B5563),
                                  fontSize: ResponsiveFontSizes.fontSize13(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  lineHeight: 1.4,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              OnestText(
                                text: "₹${order.amount}",
                                color: myColors?.txt,
                                fontSize: ResponsiveFontSizes.fontSize17(
                                  context,
                                ),
                                fontWeight: FontWeight.w700,
                                lineHeight: 1.4,
                              ),
                              OnestText(
                                text:
                                    "${order.paymentType} ₹${order.collectAmount}",
                                color: Color(0xff4B5563),
                                fontSize: ResponsiveFontSizes.fontSize13(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                                lineHeight: 1.4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Order information
                    Container(
                      width: width,
                      padding: EdgeInsets.fromLTRB(
                        12,
                        10,
                        12,
                        order.isCod ? 12 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OnestText(
                            text: "Order Information",
                            color: myColors?.txt,
                            fontSize: ResponsiveFontSizes.fontSize18(context),
                            fontWeight: FontWeight.w600,
                          ),

                          informationRow(context, "Order ID", order.orderId),
                          Container(height: 1, color: Color(0xffE5E7EB)),
                          informationRow(
                            context,
                            "Payment Method",
                            order.paymentType,
                          ),
                          Container(height: 1, color: Color(0xffE5E7EB)),
                          informationRow(
                            context,
                            "Order Amount",
                            "₹${order.orderAmount}",
                          ),
                          if (order.orderType != null) ...[
                            Container(height: 1, color: Color(0xffE5E7EB)),
                            informationRow(
                              context,
                              "Order Type",
                              order.orderType!,
                            ),
                          ],

                          if (order.isCod)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffEEF8F0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OnestText(
                                          text: "Cash Collected",
                                          color: myColors?.txt,
                                          fontSize:
                                              ResponsiveFontSizes.fontSize18(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      OnestText(
                                        text: "₹${order.collectAmount}",
                                        color: myColors?.greenColor,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize18(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OnestText(
                                          text: "Cash Collected",
                                          color: Color(0xff4B5563),
                                          fontSize:
                                              ResponsiveFontSizes.fontSize15(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      OnestText(
                                        text: order.deliveredOn ?? "-",
                                        color: Color(0xff4B5563),
                                        fontSize:
                                            ResponsiveFontSizes.fontSize15(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Delivery timeline
                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OnestText(
                            text: "Delivery Timeline",
                            color: myColors?.txt,
                            fontSize: ResponsiveFontSizes.fontSize18(context),
                            fontWeight: FontWeight.w600,
                          ),

                          SizedBox(height: 13),

                          for (
                            int i = 0;
                            i < controller.timeline.length;
                            i++
                          )
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 1),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: myColors?.greenColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (i != controller.timeline.length - 1)
                                          Expanded(
                                            child: Container(
                                              width: 2,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 7,
                                                  ),
                                              color: myColors?.greenColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 16),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OnestText(
                                          text: controller.timeline[i][0],
                                          color: myColors?.txt,
                                          fontSize:
                                              ResponsiveFontSizes.fontSize17(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w600,
                                          lineHeight: 1.4,
                                        ),
                                        OnestText(
                                          text: controller.timeline[i][1] ?? "-",
                                          color: Color(0xff4B5563),
                                          fontSize:
                                              ResponsiveFontSizes.fontSize16(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        if (i != controller.timeline.length - 1)
                                          SizedBox(height: 19),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          if (order.customerNote != null ||
                              order.capturedPhoto != null) ...[
                            SizedBox(height: 18),

                            Container(
                              width: width,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xffF3F4F6),
                                border: Border.all(color: Color(0xffE5E7EB)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  if (order.customerNote != null)
                                    Container(
                                      width: width,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          OnestText(
                                            text: "Customer Note",
                                            color: myColors?.txt,
                                            fontSize:
                                                ResponsiveFontSizes.fontSize15(
                                                  context,
                                                ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(height: 4),
                                          OnestText(
                                            text: order.customerNote,
                                            color: Color(0xff4B5563),
                                            fontSize:
                                                ResponsiveFontSizes.fontSize16(
                                                  context,
                                                ),
                                            fontWeight: FontWeight.w400,
                                            lineHeight: 1.4,
                                          ),
                                        ],
                                      ),
                                    ),

                                  if (order.customerNote != null &&
                                      order.capturedPhoto != null)
                                    SizedBox(height: 12),

                                  if (order.capturedPhoto != null)
                                    Container(
                                      width: width,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          OnestText(
                                            text: "Capture Photo",
                                            color: myColors?.txt,
                                            fontSize:
                                                ResponsiveFontSizes.fontSize15(
                                                  context,
                                                ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(height: 4),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Stack(
                                              children: [
                                                AspectRatio(
                                                  aspectRatio: 0.83,
                                                  child: Image.network(
                                                    order.capturedPhoto!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => Container(
                                                          color: Color(
                                                            0xffE5E7EB,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .image_not_supported_outlined,
                                                            color: Color(
                                                              0xff9CA3AF,
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 16,
                                                  right: 16,
                                                  child: Icon(
                                                    Icons.open_in_full,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
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
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget informationRow(BuildContext context, String label, String value) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: OnestText(
              text: label,
              color: Color(0xff4B5563),
              fontSize: ResponsiveFontSizes.fontSize16(context),
              fontWeight: FontWeight.w400,
            ),
          ),
          OnestText(
            text: value,
            color: myColors?.txt,
            fontSize: ResponsiveFontSizes.fontSize16(context),
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
