import 'dart:ui';

import 'package:flutter/material.dart';

class WGlassBox extends StatelessWidget {
  const WGlassBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.background = Colors.white,
  });
  final EdgeInsets padding;
  final Color background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              background.withOpacity(0.5),
              background.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 1.5,
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: padding,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 2.0,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
