// import 'package:flutter/material.dart';
// import 'package:sanlak_delivery_app/common/app_theme.dart';
// import 'package:sanlak_delivery_app/common/customText.dart';
// import 'package:sanlak_delivery_app/common/responsive_font.dart';

// class CheckInSteps extends StatelessWidget {
//   final int currentIndex;
//   final List<String> labels;
//   final double nodeSize;
//   final double dashWidth;
//   final double dashGap;

//   const CheckInSteps({
//     super.key,
//     required this.currentIndex,
//     required this.labels,
//     this.nodeSize = 17,
//     this.dashWidth = 7,
//     this.dashGap = 5,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final myColors = Theme.of(context).extension<MyColors>();
//     final activeColor = myColors?.primary ?? const Color(0xffFF6B2C);
//     final completeColor = myColors?.green ?? const Color(0xff08A820);
//     final pendingColor = myColors?.borderGray ?? const Color(0xffE5E5E5);
//     final labelColor = myColors?.txt ?? Colors.black;
//     final inactiveLabelColor = myColors?.primaryText ?? const Color(0xff777777);

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (int index = 0; index < labels.length; index++) ...[
//           if (index > 0)
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(top: nodeSize / 2),
//                 child: _StepDashLine(
//                   color: pendingColor.withOpacity(0.75),
//                   dashWidth: dashWidth,
//                   dashGap: dashGap,
//                 ),
//               ),
//             ),
//           _CheckInStepNode(
//             label: labels[index],
//             state: _stateFor(index),
//             nodeSize: nodeSize,
//             activeColor: activeColor,
//             completeColor: completeColor,
//             pendingColor: pendingColor,
//             labelColor: labelColor,
//             inactiveLabelColor: inactiveLabelColor,
//             alignment: index == 0
//                 ? CrossAxisAlignment.start
//                 : index == labels.length - 1
//                 ? CrossAxisAlignment.end
//                 : CrossAxisAlignment.center,
//           ),
//         ],
//       ],
//     );
//   }

//   _CheckInStepState _stateFor(int index) {
//     if (currentIndex >= labels.length - 1 || index < currentIndex) {
//       return _CheckInStepState.complete;
//     }
//     if (index == currentIndex) {
//       return _CheckInStepState.active;
//     }
//     return _CheckInStepState.pending;
//   }
// }

// class TripStepper extends CheckInSteps {
//   TripStepper({
//     super.key,
//     required super.currentIndex,
//     required List label,
//   }) : super(labels: label.map((value) => value.toString()).toList());
// }

// enum _CheckInStepState { complete, active, pending }

// class _CheckInStepNode extends StatelessWidget {
//   final String label;
//   final _CheckInStepState state;
//   final double nodeSize;
//   final Color activeColor;
//   final Color completeColor;
//   final Color pendingColor;
//   final Color labelColor;
//   final Color inactiveLabelColor;
//   final CrossAxisAlignment alignment;

//   const _CheckInStepNode({
//     required this.label,
//     required this.state,
//     required this.nodeSize,
//     required this.activeColor,
//     required this.completeColor,
//     required this.pendingColor,
//     required this.labelColor,
//     required this.inactiveLabelColor,
//     required this.alignment,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isComplete = state == _CheckInStepState.complete;
//     final isActive = state == _CheckInStepState.active;

//     return SizedBox(
//       width: 72,
//       child: Column(
//         crossAxisAlignment: alignment,
//         children: [
//           Container(
//             height: nodeSize,
//             width: nodeSize,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isComplete ? completeColor : Colors.white,
//               border: Border.all(
//                 color: isComplete
//                     ? completeColor
//                     : isActive
//                     ? activeColor
//                     : pendingColor,
//                 width: isActive ? 1.5 : 1,
//               ),
//             ),
//             child: isComplete
//                 ? Icon(Icons.check, size: nodeSize - 7, color: Colors.white)
//                 : isActive
//                 ? Container(
//                     height: nodeSize - 9,
//                     width: nodeSize - 9,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: activeColor,
//                     ),
//                   )
//                 : null,
//           ),
//           const SizedBox(height: 7),
//           PlusJakartaText(
//             text: label,
//             color: isActive
//                 ? activeColor
//                 : isComplete
//                 ? labelColor
//                 : inactiveLabelColor,
//             fontSize: ResponsiveFontSizes.fontSize12(context),
//             fontWeight: isComplete || isActive
//                 ? FontWeight.w800
//                 : FontWeight.w600,
//             lineHeight: 1.2,
//             maxLines: 1,
//             textOverflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StepDashLine extends StatelessWidget {
//   final Color color;
//   final double dashWidth;
//   final double dashGap;

//   const _StepDashLine({
//     required this.color,
//     required this.dashWidth,
//     required this.dashGap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final count = (constraints.maxWidth / (dashWidth + dashGap))
//             .floor()
//             .clamp(0, 100);
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(
//             count,
//             (_) => SizedBox(
//               width: dashWidth,
//               height: 1,
//               child: DecoratedBox(decoration: BoxDecoration(color: color)),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum CheckInStepStatus { completed, active, pending }

class CheckInStepsController extends GetxController {
  CheckInStepsController({
    required this.steps,
    int initialStep = 0,
  }) : currentStep = initialStep.obs;


  final List<String> steps;

  final RxInt currentStep;

  CheckInStepStatus statusFor(int index) {
    if (index < currentStep.value) return CheckInStepStatus.completed;
    if (index == currentStep.value) return CheckInStepStatus.active;
    return CheckInStepStatus.pending;
  }

  bool get isFirstStep => currentStep.value == 0;
  bool get isLastStep => currentStep.value == steps.length - 1;

  void nextStep() {
    if (!isLastStep) currentStep.value++;
  }

  void previousStep() {
    if (!isFirstStep) currentStep.value--;
  }

  void goToStep(int index) {
    if (index >= 0 && index < steps.length) currentStep.value = index;
  }

  void complete() {
    currentStep.value = steps.length; // all steps show as completed
  }

  void reset() => currentStep.value = 0;
}

class CheckInSteps extends StatelessWidget {
  const CheckInSteps({
    super.key,
    this.controller,
    this.steps,
    this.currentStep,
    this.completedColor = const Color(0xFF2ECC40),
    this.activeColor = const Color(0xFFFF7A1A),
    this.pendingColor = const Color(0xFFD9D9D9),
    this.circleSize = 22,
    this.labelStyle,
  }) : assert(
          controller != null || (steps != null && currentStep != null),
          'Provide either a CheckInStepsController, or both steps and currentStep.',
        );

  final CheckInStepsController? controller;

  final List<String>? steps;
  final int? currentStep;

  final Color completedColor;
  final Color activeColor;
  final Color pendingColor;
  final double circleSize;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      return Obx(() => _buildRow(
            controller!.steps,
            controller!.currentStep.value,
          ));
    }
    return _buildRow(steps!, currentStep!);
  }

  Widget _buildRow(List<String> stepLabels, int active) {
    final children = <Widget>[];

    for (var i = 0; i < stepLabels.length; i++) {
      final status = i < active
          ? CheckInStepStatus.completed
          : i == active
              ? CheckInStepStatus.active
              : CheckInStepStatus.pending;

      children.add(Expanded(
        child: _StepItem(
          label: stepLabels[i],
          status: status,
          completedColor: completedColor,
          activeColor: activeColor,
          pendingColor: pendingColor,
          circleSize: circleSize,
          labelStyle: labelStyle,
          isFirst: i == 0,
          isLast: i == stepLabels.length - 1,
        ),
      ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.label,
    required this.status,
    required this.completedColor,
    required this.activeColor,
    required this.pendingColor,
    required this.circleSize,
    required this.isFirst,
    required this.isLast,
    this.labelStyle,
  });

  final String label;
  final CheckInStepStatus status;
  final Color completedColor;
  final Color activeColor;
  final Color pendingColor;
  final double circleSize;
  final bool isFirst;
  final bool isLast;
  final TextStyle? labelStyle;

  Color get _textColor {
    switch (status) {
      case CheckInStepStatus.completed:
        return Colors.black87;
      case CheckInStepStatus.active:
        return activeColor;
      case CheckInStepStatus.pending:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Left connector line (hidden for the first step)
            Expanded(
              child: isFirst
                  ? const SizedBox()
                  : _DashedLine(
                      color: status == CheckInStepStatus.pending
                          ? pendingColor
                          : pendingColor,
                    ),
            ),
            _StepCircle(
              status: status,
              size: circleSize,
              completedColor: completedColor,
              activeColor: activeColor,
              pendingColor: pendingColor,
            ),
            // Right connector line (hidden for the last step)
            Expanded(
              child: isLast
                  ? const SizedBox()
                  : _DashedLine(color: pendingColor),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: (labelStyle ?? const TextStyle(fontSize: 12)).copyWith(
            color: _textColor,
            fontWeight: status == CheckInStepStatus.pending
                ? FontWeight.normal
                : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({
    required this.status,
    required this.size,
    required this.completedColor,
    required this.activeColor,
    required this.pendingColor,
  });

  final CheckInStepStatus status;
  final double size;
  final Color completedColor;
  final Color activeColor;
  final Color pendingColor;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case CheckInStepStatus.completed:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: completedColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 14),
        );

      case CheckInStepStatus.active:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: activeColor, width: 2),
          ),
          alignment: Alignment.center,
          child: Container(
            width: size * 0.4,
            height: size * 0.4,
            decoration: BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          ),
        );

      case CheckInStepStatus.pending:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: pendingColor, width: 1.5),
          ),
        );
    }
  }
}

/// A thin dashed horizontal line used to connect the step circles.
class _DashedLine extends StatelessWidget {
  const _DashedLine({required this.color, this.height = 1.5});

  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        const dashSpace = 3.0;
        final dashCount =
            (constraints.constrainWidth() / (dashWidth + dashSpace)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class CheckInStepsDemoScreen extends StatelessWidget {
  const CheckInStepsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CheckInStepsController(
        steps: const ['Upload Selfie', 'Enter OTP', 'Truck Image'],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Check-In')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CheckInSteps(controller: controller),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controller.previousStep,
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: controller.nextStep,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}