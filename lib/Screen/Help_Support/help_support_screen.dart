import 'package:chotekisan_delivery_app/Screen/Help_Support/help_support_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportScreen extends GetView<HelpSupportController> {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppHeader(title: "Help & Support", showBack: true),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: OnestText(
                text: "Quick Support",
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize20(context),
                fontWeight: FontWeight.w700,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _SupportTile(
                      title: "Chat with Support",
                      subtitle: "Chat with our support team",
                      icon: Icons.sms_outlined,
                      onTap: controller.chatWithSupport,
                    ),
                    _tileDivider(),
                    _SupportTile(
                      title: "Call Support",
                      subtitle: "Speak to our support executive",
                      icon: Icons.call_outlined,
                      onTap: controller.callSupport,
                    ),
                    _tileDivider(),
                    _SupportTile(
                      title: "Email Support",
                      subtitle: "Send us an email, we will respond soon",
                      icon: Icons.mail_outline_rounded,
                      onTap: controller.emailSupport,
                    ),
                    _tileDivider(),
                    _SupportTile(
                      title: "FAQs",
                      subtitle: "Find answers to common questions",
                      icon: Icons.help_outline_rounded,
                      onTap: controller.openFaqs,
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

  Widget _tileDivider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Divider(height: 1, thickness: 1, color: Color(0xffF0F1F3)),
  );
}

class _SupportTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SupportTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                color: Color(0xffD2F0D7),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: myColors?.green),
            ),

            const SizedBox(width: 12),
            Expanded(
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
                    text: subtitle,
                    color: myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize15(context),
                    fontWeight: FontWeight.w400,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: myColors?.primaryText,
            ),
          ],
        ),
      ),
    );
  }
}
