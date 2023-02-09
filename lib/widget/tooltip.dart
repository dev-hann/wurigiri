import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class WToolTip extends StatelessWidget {
  const WToolTip({
    super.key,
    required this.direction,
    required this.content,
    required this.child,
  });
  final AxisDirection direction;
  final Widget content;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      triggerMode: TooltipTriggerMode.longPress,
      preferredDirection: direction,
      content: content,
      child: child,
    );
  }
}
