import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Top row of an order card: icon, order id, distance, price and a divider.
class OrderCardHeader extends StatelessWidget {
  final OrderModel order;
  final bool showDistance;
  final bool showPaymentType;

  const OrderCardHeader({
    super.key,
    required this.order,
    this.showDistance = true,
    this.showPaymentType = true,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Column(
      children: [
        Row(
          children: [
            Image.asset(AssetImagePath.orderIcon, height: 24, width: 24),
            const SizedBox(width: 8),
            Expanded(
              child: OnestText(
                text: order.orderId,
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize17(context),
                fontWeight: FontWeight.w700,
              ),
            ),
            if (showDistance) ...[
              Icon(Icons.route_outlined, size: 14, color: myColors?.primary),
              const SizedBox(width: 2),
              OnestText(
                text: order.distance,
                color: myColors?.primary,
                fontSize: ResponsiveFontSizes.fontSize14(context),
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(width: 20),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                OnestText(
                  text: "₹${order.amount}",
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize20(context),
                  fontWeight: FontWeight.w700,
                  lineHeight: showPaymentType ? 1.15 : 1.4,
                ),
                if (showPaymentType)
                  OnestText(
                    text: order.paymentType,
                    color: myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize13(context),
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.4,
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(height: 1, color: Color(0xffD1D5DB)),
      ],
    );
  }
}

/// PICKUP / DROP-OFF block. [showConnector] draws the dashed line down to the
/// next block.
class OrderAddressBlock extends StatelessWidget {
  /// Material icon, used when [svgIcon] is not given.
  final IconData? icon;

  /// Svg asset path shown instead of [icon]. Drawn in its own colours.
  final String? svgIcon;
  final String label;
  final String name;
  final String address;
  final bool showConnector;

  const OrderAddressBlock({
    super.key,
    this.icon,
    this.svgIcon,
    required this.label,
    required this.name,
    required this.address,
    this.showConnector = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 13,
            child: Column(
              children: [
                const SizedBox(height: 1),
                svgIcon != null
                    ? SvgPicture.asset(svgIcon!, height: 18, width: 18)
                    : Icon(icon, size: 13, color: Color(0xff4B5563)),
                if (showConnector)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                       child: CustomPaint(
                        painter: DashedLinePainter(color: Color(0xff6B7280)),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnestText(
                  text: label,
                  color: Color(0xff4B5563),
                  fontSize: ResponsiveFontSizes.fontSize13(context),
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 3),
                OnestText(
                  text: name,
                  color: Color(0xff374151),
                  fontSize: ResponsiveFontSizes.fontSize15(context),
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 2),
                OnestText(
                  text: address,
                  color: Color(0xff4B5563),
                  fontSize: ResponsiveFontSizes.fontSize14(context),
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.35,
                ),
                if (showConnector) const SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
