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

  static WBottomSheet image({
    VoidCallback? onTapCamera,
    VoidCallback? onTapGarelly,
    VoidCallback? onTapRemove,
    required VoidCallback onTapCancel,
  }) {
    final List<WBottomSheetButton> actionList = [];
    if (onTapCamera != null) {
      actionList.add(
        WBottomSheetButton(
          onTap: onTapCamera,
          text: "카메라",
        ),
      );
    }
    if (onTapGarelly != null) {
      actionList.add(
        WBottomSheetButton(
          onTap: onTapGarelly,
          text: "앨범",
        ),
      );
    }
    if (onTapRemove != null) {
      actionList.add(
        WBottomSheetButton(
          onTap: onTapRemove,
          isRed: true,
          text: "삭제",
        ),
      );
    }
    return WBottomSheet(
      title: const Text("사진 선택"),
      actions: actionList,
      cancelButton: WBottomSheetButton.cancel(
        onTap: onTapCancel,
      ),
    );
  }

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
    String text = "취소",
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
