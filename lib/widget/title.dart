import 'package:flutter/material.dart';

class WTitle extends StatelessWidget {
  const WTitle({
    super.key,
    required this.title,
    this.onTapTitle,
    this.trailing = const SizedBox(),
    required this.child,
  });
  final VoidCallback? onTapTitle;
  final Widget title;
  final Widget child;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            onTapTitle?.call();
          },
          child: Row(
            children: [
              Expanded(child: title),
              trailing,
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        child,
      ],
    );
  }
}
