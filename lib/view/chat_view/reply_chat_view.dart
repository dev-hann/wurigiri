import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/chat/chat.dart';

class ReplyChatView extends StatelessWidget {
  const ReplyChatView({
    super.key,
    required this.replyChat,
    this.onTapCancel,
    this.onTapReply,
  });
  final Chat? replyChat;
  final VoidCallback? onTapCancel;
  final Function(Chat replyChat)? onTapReply;
  @override
  Widget build(BuildContext context) {
    if (replyChat == null) {
      return const SizedBox();
    }
    Widget header = const SizedBox();
    Widget body = const SizedBox();
    Widget tail = const SizedBox();
    if (onTapCancel != null) {
      tail = IconButton(
        onPressed: onTapCancel,
        icon: const Icon(Icons.cancel),
      );
    }
    switch (replyChat!.type) {
      case ChatType.text:
        body = Text(
          (replyChat as TextChat).text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        );
        break;
      case ChatType.photo:
        header = Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CachedNetworkImage(
            imageUrl: (replyChat as PhotoChat).photoURL,
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        );
        body = const Text("사진");
        break;
      case ChatType.system:
      case ChatType.removed:
        break;
    }
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: Get.width * 0.4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          Expanded(
            child: GetBuilder<UserController>(
              builder: (controller) {
                final sender = controller.loadUser(replyChat!.senderIndex);
                return GestureDetector(
                  onTap: () {
                    onTapReply?.call(replyChat!);
                  },
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${sender.name}에게 답장"),
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: body,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          tail,
        ],
      ),
    );
  }
}
