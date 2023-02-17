import 'package:flutter/material.dart';
import 'package:wurigiri/consts/const.dart';

class WBackground extends StatelessWidget {
  const WBackground({
    super.key,
    this.child = const SizedBox.expand(),
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.transparent,
              Colors.black.withOpacity(0.1),
            ],
          ).createShader(bounds);
        },
        child: ColoredBox(
          color: WColor.pink,
          child: child,
        ),
      ),
    );
  }
}
