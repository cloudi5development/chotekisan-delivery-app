import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Green rounded header with a centred title, optional back arrow and the
/// support button.
class CustomAppHeader extends StatelessWidget {
  final String title;
  final bool showBack;
  final bool showSupport;
  final VoidCallback? onBack;
  final VoidCallback? onSupport;

  const CustomAppHeader({
    super.key,
    required this.title,
    this.showBack = false,
    this.showSupport = true,
    this.onBack,
    this.onSupport,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18, topPadding + 8, 20, 13),
      decoration: const BoxDecoration(
        color: Color(0xff066006),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SizedBox(
        height: 32,
        child: Stack(
          alignment: Alignment.center,
          children: [
            OnestText(
              text: title,
              color: Colors.white,
              fontSize: ResponsiveFontSizes.fontSize17(context),
              fontWeight: FontWeight.w600,
            ),

            if (showBack)
              Positioned(
                left: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Icon(
                      Icons.arrow_back,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            if (showSupport)
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: onSupport,
                child: Container(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
