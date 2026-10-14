import 'package:chotekisan_delivery_app/Screen/Refer_Earn/refer_earn_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReferEarnScreen extends GetView<ReferEarnController> {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // Gradient hero with the app bar, gift and referral code.
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImagePath.rewardBG),
                    fit: BoxFit.fill,
                  ),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xff066006),
                  //     Color(0xff2E8B0E),
                  //     Color(0xff9ABB0A),
                  //   ],
                  //   stops: [0, 0.55, 1],
                  // ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    // App bar row
                    
                    Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        OnestText(
                          text: "Refer & Earn",
                          color: Colors.white,
                          fontSize: ResponsiveFontSizes.fontSize17(context),
                          fontWeight: FontWeight.w600,
                        ),
                        Spacer(),
                        Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AssetSvgPath.supportIcon,
                            height: 18,
                            width: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Image.asset(AssetImagePath.gift, height: 100, width: 125),
                    const SizedBox(height: 18),

                    // Referral code + copy button
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   colors: [
                              //     const Color(0xffD7E422)
                              //         .withValues(alpha: 0.55),
                              //     const Color(0xffB9D112)
                              //         .withValues(alpha: 0.35),
                              //   ],
                              // ),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OnestText(
                                  text: "Your Referral Code",
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: ResponsiveFontSizes.fontSize14(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 2),
                                Obx(
                                  () => OnestText(
                                    text: controller.referralCode.value,
                                    color: Colors.white,
                                    fontSize: ResponsiveFontSizes.fontSize19(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => controller.copyCode(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                            child: Column(
                              children: [
                                OnestText(
                                  text: "Copy",
                                  color: Colors.white,
                                  fontSize: ResponsiveFontSizes.fontSize14(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(height: 2),
                                SvgPicture.asset(AssetSvgPath.copyIcon),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Earnings summary, shown once the partner has referrals.
              Obx(
                () => controller.totalReferrals.value == 0
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OnestText(
                                text: "Your Earnings",
                                color: myColors?.txt,
                                fontSize: ResponsiveFontSizes.fontSize18(
                                  context,
                                ),
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 14),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _EarningStat(
                                        label: "Total Referrals",
                                        value:
                                            "${controller.totalReferrals.value}",
                                        valueColor: myColors?.txt,
                                      ),
                                    ),
                                    const VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: Color(0xffF0F1F3),
                                    ),
                                    Expanded(
                                      child: _EarningStat(
                                        label: "Total Earned",
                                        value:
                                            "₹${controller.totalEarned.value}",
                                        valueColor: myColors?.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),

              // How it works
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OnestText(
                        text: "How it works",
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize18(context),
                        fontWeight: FontWeight.w700,
                      ),

                      const SizedBox(height: 16),
                      const _HowItWorksStep(
                        number: "1",
                        title: "Share your referral code",
                        description: "Share your code with your friends and fellow delivery partners.",
                      ),
                      const _HowItWorksStep(
                        number: "2",
                        title: "They join and complete",
                        description: "Your friend signs up and completes their first delivery.",
                      ),
                      const _HowItWorksStep(
                        number: "3",
                        title: "You earn rewards",
                        description: "Once their first delivery is completed, you earn the reward.",
                        isLast: true,
                      ),

                      const SizedBox(height: 16),

                      // Share options
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                        decoration: BoxDecoration(
                          color: const Color(0xffF1F2F4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OnestText(
                              text: "Share your code",
                              color: myColors?.txt,
                              fontSize: ResponsiveFontSizes.fontSize17(context),
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _ShareOption(
                                  label: "Whatsapp",
                                  background: Colors.white,
                                  icon: AssetSvgPath.whatsappIcon,
                                  onTap: controller.shareViaWhatsapp,
                                ),
                                _ShareOption(
                                  label: "SMS",
                                  background: Colors.white,
                                  icon: AssetSvgPath.smsIcon,
                                  onTap: controller.shareViaSms,
                                ),
                                _ShareOption(
                                  label: "Share Link",
                                  background: Colors.white,
                                  icon: AssetSvgPath.shareIcon,
                                  onTap: controller.shareLink,
                                ),
                                _ShareOption(
                                  label: "More",
                                  background: Colors.white,
                                  icon: AssetSvgPath.moreIcon,
                                  onTap: controller.shareMore,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Invite banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
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
                              text: "Invite more, Earn more!",
                              color: myColors?.txt,
                              fontSize: ResponsiveFontSizes.fontSize17(context),
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 2),
                            OnestText(
                              text:
                                  "There's no limit to how much you can earn.",
                              color: myColors?.primaryText,
                              fontSize: ResponsiveFontSizes.fontSize14(context),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(AssetImagePath.gift, height: 45),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EarningStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _EarningStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Column(
      children: [
        OnestText(
          text: label,
          color: myColors?.primaryText,
          fontSize: ResponsiveFontSizes.fontSize15(context),
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        OnestText(
          text: value,
          color: valueColor,
          fontSize: ResponsiveFontSizes.fontSize22(context),
          fontWeight: FontWeight.w800,
        ),
      ],
    );
  }
}

/// Numbered step with a connector line down to the next step.
class _HowItWorksStep extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final bool isLast;

  const _HowItWorksStep({
    required this.number,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                height: 28,
                width: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xffD2F0D7),
                  shape: BoxShape.circle,
                ),
                child: OnestText(
                  text: number,
                  color: myColors?.green,
                  fontSize: ResponsiveFontSizes.fontSize15(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (!isLast)
                const Expanded(
                  child: VerticalDivider(
                    width: 1,
                    thickness: 1.5,
                    color: Color(0xffD2F0D7),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OnestText(
                    text: title,
                    color: myColors?.txt,
                    fontSize: ResponsiveFontSizes.fontSize17(context),
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 2),
                  OnestText(
                    text: description,
                    color: myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize15(context),
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final String label;
  final Color background;
  final String icon;
  final VoidCallback onTap;

  const _ShareOption({
    required this.label,
    required this.background,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(height: 6),
          OnestText(
            text: label,
            color: myColors?.primaryText,
            fontSize: ResponsiveFontSizes.fontSize14(context),
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
