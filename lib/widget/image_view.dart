import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WImageView extends StatelessWidget {
  const WImageView(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
