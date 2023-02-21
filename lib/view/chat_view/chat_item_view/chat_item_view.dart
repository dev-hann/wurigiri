library chat_item_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/chat_view/reply_chat_view.dart';
import 'package:wurigiri/widget/head_photo.dart';
import 'package:wurigiri/widget/image_layout.dart';
import 'package:wurigiri/widget/loading.dart';

part './chat_text_body.dart';
part './chat_photo_body.dart';
part './system_chat_view.dart';
part './chat_tool_tip.dart';
part './chat_removed_body.dart';

class ChatItemView extends StatefulWidget {
  const ChatItemView({
    super.key,
    required this.sender,
    required this.chat,
    required this.replyChat,
    required this.toolTipController,
    required this.isRead,
    required this.isMine,
    required this.onTapHeadPhoto,
    required this.onTapToolTipRemove,
    required this.onTapToolTipReply,
    required this.onTapReply,
    required this.onTapPhoto,
  });
  final User sender;
  final Chat chat;
  final Chat? replyChat;
  final bool isRead;
  final bool isMine;
  final ChatToolpTipController toolTipController;

  final VoidCallback onTapHeadPhoto;
  final VoidCallback onTapToolTipRemove;
  final VoidCallback onTapToolTipReply;
  final Function(Chat replyChat) onTapReply;
  final Function(int index) onTapPhoto;

  @override
  State<ChatItemView> createState() => ChatItemViewState();
}

class ChatItemViewState extends State<ChatItemView>
    with TickerProviderStateMixin {
  late final AnimationController shakeController;
  @override
  void initState() {
    super.initState();
    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0,
      upperBound: 1,
    );
  }

  void shake() async {
    for (int index = 0; index < 2; index++) {
      await shakeController.forward();
      await shakeController.reverse();
    }
    shakeController.reset();
  }

  Widget headPhoto() {
    if (widget.isMine) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: widget.onTapHeadPhoto,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WHeadPhoto(
              widget.sender.headPhoto,
              size: 48.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget body() {
    final width = Get.width;
    final maxWith = width * 0.6;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWith),
      child: ChatToolTip(
        controller: widget.toolTipController,
        chat: widget.chat,
        isMine: widget.isMine,
        onTapRemove: widget.onTapToolTipRemove,
        onTapReply: widget.onTapToolTipReply,
        child: Builder(
          builder: (context) {
            final type = widget.chat.type;
            switch (type) {
              case ChatType.text:
                final textChat = widget.chat as TextChat;
                return _ChatTextBody(
                  textChat,
                  replyChat: widget.replyChat,
                  onTapReply: widget.onTapReply,
                );
              case ChatType.photo:
                final photoChat = widget.chat as PhotoChat;
                return _ChatPhotoBody(
                  photoChat,
                  width: maxWith,
                  onTapPhoto: widget.onTapPhoto,
                );
              case ChatType.system:
                return const SizedBox();
              case ChatType.removed:
                final removedChat = widget.chat as RemovedChat;
                return _ChatRemovedBody(
                  chat: removedChat,
                );
            }
          },
        ),
      ),
    );
  }

  Widget readText() {
    if (!widget.isMine) {
      return const SizedBox();
    }
    return Text(widget.isRead ? "읽음" : "");
  }

  Widget tailing() {
    final data = widget.chat.dateTime;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        readText(),
        Text(intl.DateFormat("HH:mm").format(data)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chat.type == ChatType.system) {
      return SystemChatView(
        chat: widget.chat as SystemChat,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: IntrinsicHeight(
        child: Row(
          textDirection: widget.isMine ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            headPhoto(),
            AnimatedBuilder(
              animation: shakeController,
              builder: (BuildContext context, Widget? child) {
                final value = shakeController.value * 8;
                return Padding(
                  padding: EdgeInsets.only(
                    left: 8 + value,
                    right: 8 - value,
                  ),
                  child: body(),
                );
              },
            ),
            tailing(),
          ],
        ),
      ),
    );
  }
}
