import 'dart:math';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HeadPhoto extends StatelessWidget {
  final String url;

  const HeadPhoto(
    this.url, {
    super.key,
    this.size,
    this.badge,
    this.position,
  });
  final double? size;
  final Widget? badge;
  final badges.BadgePosition? position;

  Widget emptyWidget() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: SizedBox.square(
        dimension: kToolbarHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size ?? 100.0,
      child: badges.Badge(
        badgeContent: badge,
        position: position ?? badges.BadgePosition.bottomEnd(),
        badgeAnimation: const badges.BadgeAnimation.fade(
          toAnimate: false,
        ),
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.transparent,
        ),
        child: Builder(
          builder: (context) {
            if (url.isEmpty) {
              return emptyWidget();
            }
            return Image.network(url);
          },
        ),
      ),
    );
  }
}
