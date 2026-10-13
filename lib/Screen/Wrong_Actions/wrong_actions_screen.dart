import 'package:chotekisan_delivery_app/Screen/Wrong_Actions/wrong_actions_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WrongActionsScreen extends GetView<WrongActionsController> {
  const WrongActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const CustomAppHeader(title: "Wrong Actions", showBack: true),

            Expanded(
              child: Obx(
                () => controller.feedbacks.isEmpty
                    ? const _EmptyFeedbacks()
                    : SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.newFeedbacks.isNotEmpty) ...[
                        OnestText(
                          text: "New Feedbacks",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w700,
                        ),

                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: myColors?.green ?? const Color(0xff0A7A10),
                            ),
                          ),
                          child: Column(
                            children: [
                              for (
                                int i = 0;
                                i < controller.newFeedbacks.length;
                                i++
                              ) ...[
                                if (i > 0)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(0xffF0F1F3),
                                    ),
                                  ),
                                _FeedbackTile(
                                  feedback: controller.newFeedbacks[i],
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),
                      ],

                      if (controller.pastFeedbacks.isNotEmpty) ...[
                        OnestText(
                          text: "Past Feedbacks",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w700,
                        ),

                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF1F2F4),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              for (
                                int i = 0;
                                i < controller.pastFeedbacks.length;
                                i++
                              ) ...[
                                if (i > 0)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(0xffE4E6E9),
                                    ),
                                  ),
                                _FeedbackTile(
                                  feedback: controller.pastFeedbacks[i],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ],
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

/// Shown when the partner has no complaints at all.
class _EmptyFeedbacks extends StatelessWidget {
  const _EmptyFeedbacks();

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnestText(
              text: "No negative feedbacks yet!",
              color: myColors?.txt,
              fontSize: ResponsiveFontSizes.fontSize20(context),
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            OnestText(
              text:
                  "You don't have any complaints or wrong action reports. Your customers are happy with your service.",
              color: myColors?.primaryText,
              fontSize: ResponsiveFontSizes.fontSize15(context),
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              lineHeight: 1.4,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedbackTile extends StatelessWidget {
  final WrongActionFeedback feedback;

  const _FeedbackTile({required this.feedback});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return InkWell(
      onTap: () => _showFeedbackDetail(context, feedback),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xffEDEFF2),
                shape: BoxShape.circle,
              ),
              child: const Text("📦", style: TextStyle(fontSize: 17)),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: OnestText(
                          text: feedback.feedbackPoint,
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize17(context),
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (feedback.isNew) ...[
                        const SizedBox(width: 6),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: myColors?.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 2),
                  OnestText(
                    text:
                        "Order ID: ${feedback.orderId}  |  ${feedback.dateTime}",
                    color: myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize14(context),
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),
                  OnestText(
                    text: feedback.feedback,
                    color: myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize15(context),
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.4,
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

/// Popup with the full feedback for one order.
void _showFeedbackDetail(BuildContext context, WrongActionFeedback feedback) {
  MyColors? myColors = Theme.of(context).extension<MyColors>();
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cream header with the order info and close button.
          Container(
            color: const Color(0xffFDF1E2),
            padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
            child: Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Text("📦", style: TextStyle(fontSize: 16)),
                ),

                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OnestText(
                        text: "Order ID: ${feedback.orderId}",
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize16(ctx),
                        fontWeight: FontWeight.w700,
                      ),
                      OnestText(
                        text: feedback.dateTime,
                        color: myColors?.primaryText,
                        fontSize: ResponsiveFontSizes.fontSize14(ctx),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: Icon(
                    Icons.close_rounded,
                    size: 22,
                    color: myColors?.primaryText,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnestText(
                  text: "Feedback Point",
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize14(ctx),
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 2),
                OnestText(
                  text: feedback.feedbackPoint,
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize17(ctx),
                  fontWeight: FontWeight.w700,
                ),

                const SizedBox(height: 14),
                OnestText(
                  text: "Feedback",
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize14(ctx),
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 2),
                OnestText(
                  text: feedback.feedback,
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize16(ctx),
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.45,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
