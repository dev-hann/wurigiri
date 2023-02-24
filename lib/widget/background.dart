import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wurigiri/consts/const.dart';
import 'package:wurigiri/widget/image_view.dart';

class WBackground extends StatelessWidget {
  const WBackground({
    super.key,
    this.backgroundURL = "",
    this.child = const SizedBox.expand(),
  });

  final String backgroundURL;
  final Widget child;

  Widget backgroundImg() {
    if (backgroundURL.isEmpty) {
      return const SizedBox();
    }
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.transparent,
            Colors.black.withOpacity(0.6),
          ],
        ).createShader(bounds);
      },
      child: WImageView(
        CachedNetworkImageProvider(backgroundURL),
        fit: BoxFit.cover,
      ),
    );
  }

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
          child: Stack(
            children: [
              backgroundImg(),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
