import 'package:flutter/material.dart';

class WListTile extends StatelessWidget {
  const WListTile({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
  });
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
