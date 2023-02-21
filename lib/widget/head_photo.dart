import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:wurigiri/widget/image_view.dart';

const defaultHeadPhotoSize = 100.0;

class WHeadPhoto extends StatelessWidget {
  final String url;

  const WHeadPhoto(
    this.url, {
    super.key,
    this.size = defaultHeadPhotoSize,
    this.badge,
    this.position,
  });
  final double size;
  final Widget? badge;
  final badges.BadgePosition? position;

  Widget emptyWidget() {
    return const Center(
      child: Icon(
        Icons.person,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size / 3),
      ),
      child: SizedBox.square(
        dimension: size,
        child: badges.Badge(
          showBadge: badge != null,
          badgeContent: badge,
          position: position ?? badges.BadgePosition.bottomEnd(),
          badgeAnimation: const badges.BadgeAnimation.fade(
            toAnimate: false,
          ),
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size / 3),
            child: Builder(
              builder: (context) {
                if (url.isEmpty) {
                  return emptyWidget();
                }
                return WImageView(
                  CachedNetworkImageProvider(url),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
