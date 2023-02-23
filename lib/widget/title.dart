import 'package:flutter/material.dart';

class WTitle extends StatelessWidget {
  final Widget title;
  final Widget child;

  const WTitle({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: 8.0),
        child,
      ],
    );
  }
}
