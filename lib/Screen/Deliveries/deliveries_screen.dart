import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:chotekisan_delivery_app/Screen/Deliveries/deliveries_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/order_widgets.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:chotekisan_delivery_app/common/swipe_to_accept_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DeliveriesScreen extends GetView<DeliveriesController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: Column(
          children: [
            CustomAppHeader(title: "Deliveries"),

            SizedBox(height: 16),

            // Tabs
            SizedBox(
              height: 37,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 1,
                ),
                itemCount: controller.tabs.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => controller.selectTab(index),
                  // Obx sits inside the item so it rebuilds with the tab
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: controller.selectedTab.value == index
                            ? Color(0xffEAFBEF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: controller.selectedTab.value == index
                              ? myColors?.green ?? Colors.green
                              : Colors.grey.shade100,
                        ),
                      ),
                      child: Row(
                        children: [
                          OnestText(
                            text: controller.tabs[index],
                            color: controller.selectedTab.value == index
                                ? myColors?.greenColor
                                : myColors?.primaryText,
                            fontSize: ResponsiveFontSizes.fontSize16(context),
                            fontWeight: controller.selectedTab.value == index
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                          if (controller.selectedTab.value == index) ...[
                            SizedBox(width: 10),
                            Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: myColors?.primary,
                                shape: BoxShape.circle,
                              ),
                              child: OnestText(
                                text: controller.countText(index),
                                color: Colors.white,
                                fontSize: ResponsiveFontSizes.fontSize12(
                                  context,
                                ),
                                fontWeight: FontWeight.w600,
                                lineHeight: 1.1,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  19,
                  16,
                  20 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Obx(
                  () => Container(
                    width: width,
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnestText(
                          text:
                              "${controller.countText(controller.selectedTab.value)} ${controller.tabs[controller.selectedTab.value]} Orders",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize17(context),
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(height: 11),

                        if (controller
                            .ordersFor(controller.selectedTab.value)
                            .isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 36),
                            child: Center(
                              child: OnestText(
                                text: "No orders here yet.",
                                color: myColors?.primaryText,
                                fontSize: ResponsiveFontSizes.fontSize14(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                        for (final order in controller.ordersFor(
                          controller.selectedTab.value,
                        )) ...[
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                            decoration: BoxDecoration(
                              color: Color(0xffF3F4F6),
                              border: Border.all(color: Color(0xffE5E7EB)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: orderCard(context, order),
                          ),

                          SizedBox(height: 12),
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

  Widget orderCard(BuildContext context, OrderModel order) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    switch (controller.selectedTab.value) {
      // Available
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardHeader(order: order),

            SizedBox(height: 11),

            OrderAddressBlock(
              icon: Icons.send_rounded,
              label: "PICKUP",
              name: order.pickupName,
              address: order.pickupAddress,
            ),

            SizedBox(height: 16),

            SwipeToAcceptButton(
              key: ValueKey(order.orderId),
              onAccepted: () => controller.homeController.acceptOrder(order),
            ),
          ],
        );

      // Accepted
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardHeader(order: order),

            SizedBox(height: 11),

            OrderAddressBlock(
              icon: Icons.send_rounded,
              label: "PICKUP",
              name: order.pickupName,
              address: order.pickupAddress,
            ),

            SizedBox(height: 16),

            CustomButton(
              text: "Picked Up",
              height: 42,
              width: width,
              bgcolor: myColors?.green,
              textcolor: Colors.white,
              borderRadius: 8,
              onPressed: () => controller.homeController.markPickedUp(order),
            ),
          ],
        );

      // Picked Up
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardHeader(order: order, showPaymentType: false),

            SizedBox(height: 11),

            OrderAddressBlock(
              icon: Icons.send_rounded,
              label: "PICKUP",
              name: order.pickupName,
              address: order.pickupAddress,
              showConnector: true,
            ),
            OrderAddressBlock(
              icon: Icons.location_on,
              label: "DROP-OFF",
              name: order.customerName,
              address: order.dropAddress,
            ),

            SizedBox(height: 14),

            Row(
              children: [
                GestureDetector(
                  onTap: () => controller.homeController.callCustomer(order),
                  child: Container(
                    height: 42,
                    width: 96,
                    decoration: BoxDecoration(
                      color: Color(0xffEEF8F0),
                      border: Border.all(color: Color(0xffCFEAD6)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call_outlined,
                          size: 18,
                          color: myColors?.green,
                        ),
                        SizedBox(width: 8),
                        OnestText(
                          text: "Call",
                          color: myColors?.green,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: CustomButton(
                    text: "Start Delivery",
                    height: 42,
                    width: width,
                    bgcolor: myColors?.green,
                    textcolor: Colors.white,
                    borderRadius: 8,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () =>
                        controller.homeController.startDelivery(order),
                  ),
                ),
              ],
            ),
          ],
        );

      // Delivered
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardHeader(
              order: order,
              showDistance: false,
              showPaymentType: false,
            ),

            SizedBox(height: 11),

            OrderAddressBlock(
              icon: Icons.send_rounded,
              label: "PICKUP",
              name: order.pickupName,
              address: order.pickupAddress,
              showConnector: true,
            ),
            OrderAddressBlock(
              icon: Icons.location_on,
              label: "DROP-OFF",
              name: order.customerName,
              address: order.dropAddress,
            ),

            SizedBox(height: 12),
            Container(height: 1, color: Color(0xffD1D5DB)),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OnestText(
                        text: "Delivered On",
                        color: Color(0xff4B5563),
                        fontSize: ResponsiveFontSizes.fontSize14(context),
                        fontWeight: FontWeight.w400,
                        lineHeight: 1.35,
                      ),
                      SizedBox(height: 2),
                      OnestText(
                        text: order.deliveredOn ?? "-",
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize14(context),
                        fontWeight: FontWeight.w600,
                        lineHeight: 1.35,
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => controller.onViewDetails(order),
                  child: Row(
                    children: [
                      OnestText(
                        text: "View details",
                        color: myColors?.primary,
                        fontSize: ResponsiveFontSizes.fontSize15(context),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: myColors?.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }
}
