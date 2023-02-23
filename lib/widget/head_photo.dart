import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:wurigiri/widget/image_view.dart';

const defaultHeadPhotoSize = 100.0;

class WHeadPhoto extends StatelessWidget {
  const WHeadPhoto(
    this.url, {
    super.key,
    this.size = defaultHeadPhotoSize,
    this.badge,
    this.position,
    this.onTapBadge,
  });
  final String url;
  final double size;
  final Widget? badge;
  final badges.BadgePosition? position;
  final VoidCallback? onTapBadge;

  Widget emptyWidget() {
    return const Center(
      child: Icon(
        Icons.person,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: badge != null,
      onTap: onTapBadge,
      badgeContent: badge,
      position: position ?? badges.BadgePosition.bottomEnd(),
      badgeAnimation: const badges.BadgeAnimation.fade(
        toAnimate: false,
      ),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.transparent,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size / 3),
        ),
        child: SizedBox.square(
          dimension: size,
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
