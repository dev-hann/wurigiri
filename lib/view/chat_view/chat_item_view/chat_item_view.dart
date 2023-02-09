library chat_item_view;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';
import 'package:wurigiri/widget/head_photo.dart';
import 'package:wurigiri/widget/loading.dart';

part './chat_text_body.dart';
part './chat_photo_body.dart';
part './chat_tool_tip.dart';

class ChatItemView extends StatelessWidget {
  const ChatItemView({
    super.key,
    required this.sender,
    required this.chat,
    required this.isRead,
    required this.isMine,
  });
  final User sender;
  final Chat chat;
  final bool isRead;
  final bool isMine;

  Widget headPhoto() {
    return GestureDetector(
      onTap: () {
        Get.to(UserDetailView(user: sender));
      },
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
    return JustTheTooltip(
      triggerMode: TooltipTriggerMode.longPress,
      preferredDirection: AxisDirection.up,
      content: ChatToolTip(chat: chat),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWith,
          minWidth: minWith,
        ),
        child: Builder(
          builder: (context) {
            final type = chat.type;
            switch (type) {
              case ChatType.text:
                final textChat = chat as TextChat;
                return _ChatTextBody(textChat);
              case ChatType.photo:
                final photoChat = chat as PhotoChat;
                return _PhotoChatBody(
                  photoChat,
                  width: maxWith,
                );
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
