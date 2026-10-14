import 'package:chotekisan_delivery_app/Screen/Profile/profile_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/logout_dialog.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final topPadding = MediaQuery.paddingOf(context).top;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header with the avatar overlapping its curved bottom edge.
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: width,
                    height: topPadding + 150,
                    padding: EdgeInsets.fromLTRB(16, topPadding + 10, 16, 0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff066006),
                          Color(0xff0C8C18),
                          Color(0xff0A7A10),
                        ],
                        stops: [0, 0.65, 1],
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(28),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 40),
                        Expanded(
                          child: OnestText(
                            text: "Profile",
                            color: Colors.white,
                            fontSize: ResponsiveFontSizes.fontSize20(context),
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AssetSvgPath.supportIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Avatar sits half outside the green header.
                  Positioned(
                    top: topPadding + 90,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 54,
                            backgroundImage: AssetImage(
                              AssetImagePath.profileImage,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: Obx(
                            () => Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: controller.isOnline.value
                                    ? const Color(0xff14AE37)
                                    : const Color(0xffE02424),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 74),

              Obx(
                () => OnestText(
                  text: controller.userName.value,
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize22(context),
                  fontWeight: FontWeight.w700,
                  lineHeight: 1.3,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 4),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OnestText(
                      text: controller.partnerId.value,
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w500,
                    ),
                    _dotSeparator(myColors),
                    Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: myColors?.ratingColor ?? const Color(0xffF59E0B),
                    ),
                    const SizedBox(width: 3),
                    OnestText(
                      text: "${controller.rating.value} Ratings",
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w500,
                    ),
                    _dotSeparator(myColors),
                    OnestText(
                      text: controller.partnerType.value,
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Quick actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _QuickActionCard(
                      label: "Manage\nProfile",
                      svgIcon: AssetSvgPath.manageProfileIcon,
                      onTap: () => Get.toNamed(AppRoutes.manageProfile),
                    ),
                    const SizedBox(width: 12),
                    _QuickActionCard(
                      label: "Message\nCentre",
                      svgIcon: AssetSvgPath.mesageCentreIcon,
                      onTap: () => Get.toNamed(AppRoutes.messageCentre),
                    ),
                    const SizedBox(width: 12),
                    _QuickActionCard(
                      label: "Wrong\nActions",
                      svgIcon: AssetSvgPath.wrongActionIcon,
                      onTap: () => Get.toNamed(AppRoutes.wrongActions),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Settings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: OnestText(
                    text: "SETTINGS",
                    color: myColors?.txt,
                    fontSize: ResponsiveFontSizes.fontSize16(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _SettingsTile(
                        label: "Refer & Earn",
                        svgIcon: AssetSvgPath.referIcon,
                        onTap: () => Get.toNamed(AppRoutes.referEarn),
                      ),
                      _tileDivider(),
                      _SettingsTile(
                        label: "Incentives & Rewards",
                        svgIcon: AssetSvgPath.incentiveIcon,
                        onTap: () => Get.toNamed(AppRoutes.incentivesRewards),
                      ),
                      _tileDivider(),
                      _SettingsTile(
                        label: "Wallet",
                        svgIcon: AssetSvgPath.vehicleIcon,
                        onTap: () => Get.toNamed(AppRoutes.wallet),
                      ),
                      _tileDivider(),
                      _SettingsTile(
                        label: "Vehicle Details",
                        svgIcon: AssetSvgPath.vehicleIcon,
                        onTap: () => Get.toNamed(AppRoutes.vehicleDetails),
                      ),
                      _tileDivider(),
                      _SettingsTile(
                        label: "Documents & Verification",
                        svgIcon: AssetSvgPath.documentVerificationIcon,
                        onTap: () =>
                            Get.toNamed(AppRoutes.documentsVerification),
                      ),
                      _tileDivider(),
                      _SettingsTile(
                        label: "Notification",
                        svgIcon: AssetSvgPath.notificationIcon,
                        onTap: () => Get.toNamed(AppRoutes.notifications),
                      ),
                      _tileDivider(),
                      _SettingsTile(
                        label: "Help & Support",
                        svgIcon: AssetSvgPath.helpAndSupportIcon,
                        onTap: () => Get.toNamed(AppRoutes.helpSupport),
                      ),
                      _tileDivider(),
                      _SettingsTile(
                        label: "Logout",
                        svgIcon: AssetSvgPath.logoutIcon,
                        color: const Color(0xffE02424),
                        showChevron: false,
                        onTap: () async {
                          final confirmed = await showLogoutDialog(context);
                          if (confirmed) controller.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Keeps the last tile clear of the floating nav bar.
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dotSeparator(MyColors? myColors) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: OnestText(
      text: "|",
      color: myColors?.borderGray,
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
  );

  Widget _tileDivider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Divider(height: 1, thickness: 1, color: Color(0xffF0F1F3)),
  );
}

class _QuickActionCard extends StatelessWidget {
  final String label;
  final String svgIcon;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.label,
    required this.svgIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 12, 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(svgIcon, height: 24, width: 24),
              ),
              const SizedBox(height: 10),
              OnestText(
                text: label,
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize16(context),
                fontWeight: FontWeight.w600,
                lineHeight: 1.3,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String label;
  final String svgIcon;
  final Color? color;
  final bool showChevron;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.label,
    required this.svgIcon,
    required this.onTap,
    this.color,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        child: Row(
          children: [
            SvgPicture.asset(svgIcon, height: 22, width: 22),
            const SizedBox(width: 14),
            Expanded(
              child: OnestText(
                text: label,
                color: color ?? myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize17(context),
                fontWeight: FontWeight.w500,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            if (showChevron)
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
