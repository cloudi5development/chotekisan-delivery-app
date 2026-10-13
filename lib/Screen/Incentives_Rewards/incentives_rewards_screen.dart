import 'package:chotekisan_delivery_app/Screen/Incentives_Rewards/incentives_rewards_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IncentivesRewardsScreen extends GetView<IncentivesRewardsController> {
  const IncentivesRewardsScreen({super.key});

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
              title: "Incentives & Rewards",
              showBack: true,
            ),

            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Monthly earnings summary
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
                        decoration: BoxDecoration(
                          color: const Color(0xffE9F8EC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OnestText(
                                    text: "Total Earnings (This Month)",
                                    color: myColors?.primaryText,
                                    fontSize: ResponsiveFontSizes.fontSize16(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(height: 4),
                                  OnestText(
                                    text:
                                        "₹${controller.totalEarnings.value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')}",
                                    color: myColors?.txt,
                                    fontSize: ResponsiveFontSizes.fontSize30(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w800,
                                    lineHeight: 1.2,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward_rounded,
                                        size: 16,
                                        color: myColors?.green,
                                      ),
                                      const SizedBox(width: 2),
                                      OnestText(
                                        text:
                                            "${controller.growthPercent.value}% vs last month",
                                        color: myColors?.green,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize15(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text("🎁", style: TextStyle(fontSize: 56)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      OnestText(
                        text: "Incentives",
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize20(context),
                        fontWeight: FontWeight.w700,
                      ),

                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            for (
                              int i = 0;
                              i < controller.incentives.length;
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
                              _IncentiveTile(
                                incentive: controller.incentives[i],
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Bottom note
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8EAED),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OnestText(
                              text:
                                  "Complete the targets to earn exciting bonuses.",
                              color: myColors?.txt,
                              fontSize: ResponsiveFontSizes.fontSize16(
                                context,
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 2),
                            OnestText(
                              text:
                                  "Incentives are credited within 24-48 hours after meeting the criteria.",
                              color: myColors?.primaryText,
                              fontSize: ResponsiveFontSizes.fontSize15(
                                context,
                              ),
                              fontWeight: FontWeight.w400,
                              lineHeight: 1.4,
                            ),
                          ],
                        ),
                      ),
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

class _IncentiveTile extends StatelessWidget {
  final Incentive incentive;

  const _IncentiveTile({required this.incentive});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xffD2F0D7),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(AssetSvgPath.scooter, height: 26),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnestText(
                  text: incentive.title,
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize17(context),
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 2),
                OnestText(
                  text: incentive.description,
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize15(context),
                  fontWeight: FontWeight.w400,
                ),

                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: incentive.isEarned ? 1 : incentive.progress,
                    minHeight: 5,
                    backgroundColor: const Color(0xffE4E6E9),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      incentive.isEarned
                          ? myColors?.green ?? Colors.green
                          : const Color(0xffF59E0B),
                    ),
                  ),
                ),

                const SizedBox(height: 6),
                OnestText(
                  text:
                      "${incentive.completed}/${incentive.target} Deliveries",
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize15(context),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OnestText(
                text: "₹${incentive.amount}",
                color: incentive.isEarned ? myColors?.green : myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize19(context),
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 4),
              incentive.isEarned
                  ? Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 16,
                          color: myColors?.green,
                        ),
                        const SizedBox(width: 3),
                        OnestText(
                          text: "Earned",
                          color: myColors?.green,
                          fontSize: ResponsiveFontSizes.fontSize15(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    )
                  : OnestText(
                      text: "Locked",
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize15(context),
                      fontWeight: FontWeight.w500,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
