import 'package:flutter/material.dart';

class WImageView extends StatelessWidget {
  const WImageView(
    this.provider, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  final ImageProvider provider;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Image(
      image: provider,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
