import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';

class SwipeToAcceptButton extends StatefulWidget {
  final String text;
  final double height;

  /// Called once the thumb is dragged to the end.
  final VoidCallback onAccepted;

  const SwipeToAcceptButton({
    super.key,
    required this.onAccepted,
    this.text = "Swipe to Accept",
    this.height = 48,
  });

  @override
  State<SwipeToAcceptButton> createState() => _SwipeToAcceptButtonState();
}

class _SwipeToAcceptButtonState extends State<SwipeToAcceptButton> {
  double _drag = 0;

  @override
  Widget build(BuildContext context) {
    final thumbSize = widget.height - 10;
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxDrag = constraints.maxWidth - widget.height;
        return Container(
          height: widget.height,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff0A8A2A), Color(0xff00EE49)],
            ),
            borderRadius: BorderRadius.circular(widget.height / 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              OnestText(
                text: widget.text,
                color: Colors.white,
                fontSize: ResponsiveFontSizes.fontSize18(context),
                fontWeight: FontWeight.w500,
              ),

              Positioned(
                right: 12,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Color(0x59FFFFFF),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Color(0x800A5F0A),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Color(0xff0A5F0A),
                    ),
                  ],
                ),
              ),

              Positioned(
                left: 5 + _drag,
                top: 5,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _drag = (_drag + details.delta.dx).clamp(0, maxDrag);
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    final accepted = _drag >= maxDrag * 0.85;
                    setState(() => _drag = 0);
                    if (accepted) widget.onAccepted();
                  },
                  child: Container(
                    height: thumbSize,
                    width: thumbSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.view_in_ar_rounded,
                      size: 20,
                      color: Color(0xff0FA53A),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
