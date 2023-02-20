import 'package:flutter/cupertino.dart';

class WBottomSheet extends StatelessWidget {
  const WBottomSheet({
    super.key,
    this.title,
    this.message,
    required this.actions,
    this.cancelButton,
  });

  final Widget? title;
  final Widget? message;
  final List<WBottomSheetButton> actions;

  final WBottomSheetButton? cancelButton;

  Future show(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: title,
      message: message,
      actions: actions,
      cancelButton: cancelButton,
    );
  }
}

class WBottomSheetButton extends StatelessWidget {
  const WBottomSheetButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isBold = false,
    this.isRed = false,
  });
  final String text;
  final VoidCallback onTap;
  final bool isBold;
  final bool isRed;

  factory WBottomSheetButton.cancel({
    String text = "Cancel",
    required VoidCallback onTap,
  }) {
    return WBottomSheetButton(
      isRed: true,
      onTap: onTap,
      text: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetAction(
      isDefaultAction: isBold,
      isDestructiveAction: isRed,
      onPressed: onTap,
      child: Text(text),
    );
  }
}
