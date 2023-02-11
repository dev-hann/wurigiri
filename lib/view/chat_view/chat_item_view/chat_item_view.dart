library chat_item_view;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/chat_view/reply_chat_view.dart';
import 'package:wurigiri/widget/head_photo.dart';
import 'package:wurigiri/widget/loading.dart';

part './chat_text_body.dart';
part './chat_photo_body.dart';
part './system_chat_view.dart';
part './chat_tool_tip.dart';

class ChatItemView extends StatelessWidget {
  const ChatItemView({
    super.key,
    required this.sender,
    required this.chat,
    required this.replyChat,
    required this.toolTipController,
    required this.isRead,
    required this.isMine,
    required this.onTapHeadPhoto,
    required this.onTapRemove,
    required this.onTapReply,
  });
  final User sender;
  final Chat chat;
  final Chat? replyChat;
  final bool isRead;
  final bool isMine;
  final ChatToolpTipController toolTipController;

  final VoidCallback onTapHeadPhoto;
  final VoidCallback onTapRemove;
  final VoidCallback onTapReply;

  Widget headPhoto() {
    if (isMine) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: onTapHeadPhoto,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WHeadPhoto(
            sender.headPhoto,
            size: 48.0,
          ),
        ],
      ),
    );
  }

  Widget body() {
    final width = Get.width;
    final maxWith = width * 0.5;
    final minWith = width * 0.1;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWith,
        minWidth: minWith,
      ),
      child: ChatToolTip(
        controller: toolTipController,
        chat: chat,
        isMine: isMine,
        onTapRemove: onTapRemove,
        onTapReply: onTapReply,
        child: Builder(
          builder: (context) {
            final type = chat.type;
            switch (type) {
              case ChatType.text:
                final textChat = chat as TextChat;
                return _ChatTextBody(
                  textChat,
                  replyChat: replyChat,
                );
              case ChatType.photo:
                final photoChat = chat as PhotoChat;
                return _ChatPhotoBody(
                  photoChat,
                  width: maxWith,
                );
              case ChatType.system:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget readText() {
    if (!isMine) {
      return const SizedBox();
    }
    return Text(isRead ? "Read" : "");
  }

  Widget tailing() {
    final data = chat.dateTime;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        readText(),
        Text(intl.DateFormat("HH:mm").format(data)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (chat.type == ChatType.system) {
      return SystemChatView(
        chat: chat as SystemChat,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: IntrinsicHeight(
        child: Row(
          textDirection: isMine ? TextDirection.rtl : TextDirection.ltr,
          children: [
            headPhoto(),
            const SizedBox(width: 8.0),
            body(),
            const SizedBox(width: 8.0),
            tailing(),
          ],
        ),
      ),
    );
  }
}
