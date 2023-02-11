part of chat_item_view;

class ChatToolpTipController {
  final List<VoidCallback> _listenerList = [];

  void addListener(VoidCallback listener) {
    _listenerList.add(listener);
  }

  void remoteListener(VoidCallback listener) {
    _listenerList.remove(listener);
  }

  void hideToolTip() {
    for (final listener in _listenerList) {
      listener();
    }
  }
}

class ChatToolTip extends StatefulWidget {
  const ChatToolTip({
    super.key,
    required this.chat,
    required this.controller,
    required this.isMine,
    required this.onTapRemove,
    required this.onTapReply,
    required this.child,
  });
  final Chat chat;
  final bool isMine;
  final ChatToolpTipController controller;
  final Widget child;
  final VoidCallback onTapRemove;
  final VoidCallback onTapReply;

  @override
  State<ChatToolTip> createState() => _ChatToolTipState();
}

class _ChatToolTipState extends State<ChatToolTip> {
  final ValueNotifier<bool> _overlayNotifier = ValueNotifier(false);

  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(hideToolTip);
  }

  @override
  void dispose() {
    widget.controller.remoteListener(hideToolTip);
    super.dispose();
  }

  void hideToolTip() {
    _overlayNotifier.value = false;
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void showToolTip(BuildContext context) {
    if (overlayEntry == null) {
      return;
    }
    _overlayNotifier.value = true;
    Overlay.of(context).insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.controller.hideToolTip();
        overlayEntry = OverlayEntry(
          builder: (_) {
            return _ChatOverlay(
              childContext: context,
              isMine: widget.isMine,
              direction:
                  widget.isMine ? AxisDirection.right : AxisDirection.left,
              onTapCancel: () {
                hideToolTip();
              },
              onTapRemove: () {
                hideToolTip();
                widget.onTapRemove();
              },
              onTapReply: () {
                hideToolTip();
                widget.onTapReply();
              },
            );
          },
        );
        showToolTip(context);
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _overlayNotifier,
        builder: (context, isOverlay, _) {
          return Opacity(
            opacity: isOverlay ? 0.4 : 1,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _ChatOverlay extends StatelessWidget {
  const _ChatOverlay({
    required this.childContext,
    required this.isMine,
    required this.onTapRemove,
    required this.onTapCancel,
    required this.onTapReply,
    required this.direction,
  });
  final BuildContext childContext;
  final bool isMine;
  final VoidCallback onTapCancel;
  final VoidCallback onTapRemove;
  final VoidCallback onTapReply;
  final AxisDirection direction;

  Offset calculateOffset() {
    final box = childContext.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    return Offset(
      isMine ? offset.dx : kToolbarHeight,
      offset.dy - kToolbarHeight,
    );
  }

  Widget button({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final offset = calculateOffset();
    final buttonList = [
      button(text: "삭제", onTap: onTapRemove),
      button(text: "답변", onTap: onTapReply),
    ];
    return GestureDetector(
      onTap: onTapCancel,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fromRect(
            rect: Rect.fromLTWH(
              offset.dx,
              offset.dy,
              kToolbarHeight * buttonList.length,
              kToolbarHeight,
            ),
            child: Row(
              children: buttonList,
            ),
          ),
        ],
      ),
    );
  }
}
